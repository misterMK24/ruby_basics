require_relative 'train'
require_relative 'accessors_module'
require_relative 'validation_module'

class Station
  # include InstanceCounter
  include Validation
  extend Accessors

  attr_reader :trains
  attr_accessor_with_history :name

  @stations = []

  class << self
    def add_station(station)
      @stations << station
    end
  end

  def self.all
    @stations
  end

  validate :name, :type, String
  validate :name, :presence

  def initialize(name)
    self.name = name
    @trains = []
    self.class.add_station(self)
    validate!
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

  def validate_train_existence!(train)
    raise "train ins't on a station now" unless @trains.include?(train)
  end
end
