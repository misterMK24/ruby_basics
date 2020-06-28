class Train
  attr_reader :number, :type, :amount_carriage, :available_stations
  attr_accessor :speed, :current_station

  def initialize(number, type, amount_carriage)
    @number = number
    @type = type
    @amount_carriage = amount_carriage
    @speed = 0
  end

  def increase_speed(speed)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def add_carriage
    return "Please, stop train!" unless @speed == 0
    @amount_carriage += 1
  end

  def delete_carriage
    return "Please, stop train!" unless @speed == 0
    @amount_carriage == 0 ? "Train is empty!" : (@amount_carriage -= 1)
  end

  def add_route(route)
    @available_stations = route.stations
    route.stations.first.add_train(self)
  end

  def current_station_index
    @available_stations.index(@current_station)
  end

  def go_forward
    if @available_stations
      return "You're on a last station!" if @current_station == @available_stations.last
      next_station_index = current_station_index + 1
      @current_station.send_train(self, @available_stations[next_station_index])
    else
      "You don't have a route!"
    end
  end

  def go_back
    if @available_stations
      return "You're on a first station!" if @current_station == @available_stations.first
      next_station_index = current_station_index - 1
      @current_station.send_train(self, @available_stations[next_station_index])
    else
      "You don't have a route or station isn't in a route!"
    end
  end

  def previous_station
    return "You're on a first station!" if @current_station == @available_stations.first
    @available_stations[current_station_index - 1]
  end

  def next_station
    return "You're on a last station!" if @current_station == @available_stations.last
    @available_stations[current_station_index + 1]
  end
end
