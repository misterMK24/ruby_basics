class Station
  # include InstanceCounter

  attr_reader :trains
  attr_accessor :name

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    # register_instance
    validate_name!
  end


  def add_train(train)
    @trains << train
    train.set_current_station(self)
  end

  def send_train(train, next_station)
    validate_train_existence!
    @trains.delete(train)
    next_station.add_train(train)
  end

  private

  def valid?
    validate_name!
    true
  rescue
    false
  end

  def validate_name!
    raise "Name can't be empty" if @name.length == 0
  end

  def validate_train_existence!
    raise "train ins't on a station now" unless @trains.include?(train)
  end

  @@stations = []
end
