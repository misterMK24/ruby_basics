class Route
 #также оставим все методы и переменные в публичном доступе, которые используются в Main классе. Initialize всегда будет в private.
  attr_reader :stations

  def add_station(station)
    @stations.insert(-2, station) unless @stations.include? (station)
  end

  def delete_station(station)
    @stations.delete(station) if station != @stations.first && station != @stations.last
  end

  def show_stations
    @stations.each { |station| puts station.name }
  end

  private

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end
end
