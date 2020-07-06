require_relative "instance_counter"


class Station
  # все методы и переменные оставим в публичном доступе, так как доступ к ним необходим для корректного функционирования других классов.
  # Активно используются в Main классе.
  include InstanceCounter

  attr_reader :name, :trains

  def self.all
    @@stations.each { |station| puts station }
  end

  def add_train(train)
    @trains << train
    train.set_current_station(self)
  end

  def send_train(train, next_station)
    return puts "train ins't on a station now" unless @trains.include?(train)
    @trains.delete(train)
    next_station.add_train(train)
  end

  private

  self.declare_instance_counter

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
  end
end
