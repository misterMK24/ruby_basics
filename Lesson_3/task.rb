class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @train_list = []
  end

  def add_train(train)
    @train_list << train
    train.current_station = self
  end

  def show_trains(type = nil)
    type ? @train_list.select{ |train| train.type == type } : @train_list
  end

  def send_train(train, next_station)
    return puts "train ins't on a station now" unless @train_list.include?(train)
    @train_list.delete(train)
    next_station.add_train(train)
    show_trains
  end
end


class Route
  attr_reader :station_list

  def initialize(first_station, last_station)
    @station_list = [first_station, last_station]
  end

  def add_station(station)
    @station_list.insert(-2, station)
  end

  def delete_station(station)
    @station_list.delete(station)
  end

  def show_stations
    @station_list.each { |station| puts station.name }
  end
end


class Train
  attr_reader :number, :type, :amount_carriage, :available_stations
  attr_accessor :speed, :current_station

  def initialize(number, type, amount_carriage)
    @number = number
    @type = type
    @amount_carriage = amount_carriage
    @speed = 0
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
    @available_stations = route.station_list
    route.station_list.first.add_train(self)
  end

  def change_station(next_station)
    if @available_stations && @available_stations.include?(next_station)
      conditional_array = [-1 ,1]
      next_station_index = @available_stations.index(next_station)
      puts next_station_index
      return "Station isn't near to current station" unless conditional_array.include?(@available_stations.index(@current_station) - next_station_index)
      @current_station.send_train(self, next_station)
    else
      puts "You don't have a route or station isn't in a route!"
    end
  end

  def previous_station
    current_station_index = @available_stations.index(@current_station)
    case current_station_index
    when 0
      @available_stations[1]
    when @available_stations.size - 1
      @available_stations[-2]
    else
      @available_stations[current_station_index - 1]
    end
  end

  def next_station
    current_station_index = @available_stations.index(@current_station)
    case current_station_index
    when 0
      @available_stations[1]
    when @available_stations.size - 1
      @available_stations[-2]
    else
      @available_stations[current_station_index + 1]
    end
  end
end
