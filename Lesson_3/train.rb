require './route.rb'
require './station.rb'


class Train
  attr_reader :number, :type, :amount_carriage
  attr_accessor :speed, :current_station

  def initialize(number, type, amount_carriage)
    @number = number
    @type = type
    @amount_carriage = amount_carriage
    @speed = 0
    @route = nil
  end

  def increase_speed(speed)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def add_carriage
    return "Please, stop train!" unless @speed.zero?
    @amount_carriage += 1
  end

  def delete_carriage
    return "Please, stop train!" unless @speed.zero?
    @amount_carriage == 0 ? "Train is empty!" : (@amount_carriage -= 1)
  end

  def add_route(route)
    @route = route
    route.stations.first.add_train(self)
  end

  def current_station_index
    @route.stations.index(@current_station)
  end

  def go_forward
    if @route
      return "You're on a last station!" unless next_station
      next_station_index = current_station_index + 1
      @current_station.send_train(self, @route.stations[next_station_index])
    else
      "You don't have a route!"
    end
  end

  def go_back
    if @route
      return "You're on a first station!" unless previous_station
      next_station_index = current_station_index - 1
      @current_station.send_train(self, @route.stations[next_station_index])
    else
      "You don't have a route!"
    end
  end

  def previous_station
    return nil if @current_station == @route.stations.first
    @route.stations[current_station_index - 1]
  end

  def next_station
    return nil if @current_station == @route.stations.last
    @route.stations[current_station_index + 1]
  end
end
