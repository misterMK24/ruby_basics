require_relative "route"
require_relative "station"


class Train
  # include Manufacturer
  # include InstanceCounter

  attr_reader :number, :type, :carriages

  def self.find(number)
    @@trains.select { |key, value| key == number.to_sym }
  end

  def initialize(number)
    @number = number.to_sym
    @speed = 0
    @route = nil
    @carriages = []
    @current_station = nil
    @@trains[@number] = self
    validate_number!
    # register_instance
  end

  def increase_speed(speed)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def add_carriage(carriage)
    validate_speed!
    @carriages << carriage
  end

  def delete_carriage
    validate_speed!
    validate_carriage!
    @carriages.delete(@carriages.last)
  end

  def each_carriage
    @carriages.each.with_index(1) { |carriage, index| yield(carriage, index) }
  end

  def add_route(route)
    @route = route
    route.stations.first.add_train(self)
  end

  def set_current_station(station)
    @current_station = station
  end

  def go_forward
    validate_route!
    raise "You're on a last station" unless next_station
    next_station_index = current_station_index + 1
    @current_station.send_train(self, @route.stations[next_station_index])
    # puts "Поезд перемещен на станцию: #{self.current_station.name}"
  end

  def go_back
    validate_route!
    raise "You're on a first station" unless previous_station
    next_station_index = current_station_index - 1
    @current_station.send_train(self, @route.stations[next_station_index])
    # puts "Поезд перемещен на станцию: #{self.current_station.name}"
  end

  # методы, которые используются внутри самого класса или его наследников
  protected

  attr_reader :current_station, :speed
  attr_writer :type

  NUMBER_FORMAT = /^.{3}[-]?.{2}$/

  def valid?
    validate_number!
    true
  rescue
    false
  end

  def validate_number!
    raise "Number can't be empty" if @number.length == 0
    raise "Number has invalid format" if @number !~ NUMBER_FORMAT
  end

  def validate_route!
    raise "You don't have a route" unless @route
  end

  def validate_speed!
    raise "Please, stop train!" unless @speed.zero?
  end

  def validate_carriage!
    raise "Train is empty!" if @carriages.empty?
  end

  def current_station_index
    @route.stations.index(@current_station)
  end

  def previous_station
    return nil if @current_station == @route.stations.first
    @route.stations[current_station_index - 1]
  end

  def next_station
    return nil if @current_station == @route.stations.last
    @route.stations[current_station_index + 1]
  end

  private

  @@trains = {}
end
