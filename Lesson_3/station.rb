class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
    train.current_station = self
  end

  def show_trains(type = nil)
    type ? @trains.select{ |train| train.type == type } : @trains
  end

  def send_train(train, next_station)
    return puts "train ins't on a station now" unless @trains.include?(train)
    @trains.delete(train)
    next_station.add_train(train)
  end
end
