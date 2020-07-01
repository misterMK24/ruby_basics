class Train
  attr_reader :number

  def increase_speed(speed)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def add_carriage(carriage)
    return "Please, stop train!" unless @speed.zero?
    @carriages << carriage
  end

  def delete_carriage
    return "Please, stop train!" unless @speed.zero?
    @carriages.empty? ? "Train is empty!" : @carriages.delete(@carriages.last)
  end

  def add_route(route)
    @route = route
    route.stations.first.add_train(self)
  end

  def set_current_station(station)
    @current_station = station
  end

  def go_forward
    if @route
      return puts "You're on a last station!" unless next_station
      next_station_index = current_station_index + 1
      @current_station.send_train(self, @route.stations[next_station_index])
      puts "Поезд перемещен на станцию: #{self.current_station.name}"
    else
      puts "You don't have a route!"
    end
  end

  def go_back
    if @route
      return puts "You're on a first station!" unless previous_station
      next_station_index = current_station_index - 1
      @current_station.send_train(self, @route.stations[next_station_index])
      puts "Поезд перемещен на станцию: #{self.current_station.name}"
    else
      puts "You don't have a route!"
    end
  end

  # методы, которые используются внутри самого класса или его наследников
  protected

  attr_reader :current_station, :speed

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

  def initialize(number)
    @number = number
    @speed = 0
    @route = nil
    @carriages = []
    @current_station = nil
  end
end
