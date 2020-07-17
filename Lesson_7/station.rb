require_relative 'train'

class Station
  # include InstanceCounter

  attr_reader :trains
  attr_accessor :name

  @stations = []

  class << self
    def add_station(station)
      @stations << station
    end
  end

  def self.all
    @stations
  end

  def initialize(name)
    @name = name
    @trains = []
    self.class.add_station(self)
    # register_instance
    validate_name!
  end

  def add_train(train)
    @trains << train
    train.current_station_set(self)
  end

  def send_train(train, next_station)
    validate_train_existence!(train)
    @trains.delete(train)
    next_station.add_train(train)
  end

  def each_train
    @trains.each { |train| yield(train) }
  end

  private

  def valid?
    validate_name!
    true
  rescue StandardError
    puts 'Error'
    false
  end

  def validate_name!
    raise "Name can't be empty" if @name.empty?
  end

  def validate_train_existence!(train)
    raise "train ins't on a station now" unless @trains.include?(train)
  end
end
