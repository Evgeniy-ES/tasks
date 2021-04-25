class Route
  extend InstanceCounter
  attr_reader :stations

  @@all_routes = []

  def initialize(station1, station2)
    @stations = [station1, station2]
    @@all_routes << self
  end

  def self.instances_class
    instances(@@all_routes)
  end

  def add_station(station)
    if @stations.index(station).nil?
      @stations.insert(-2, station)
    else
      puts "Такая станция уже есть в маршрте"
    end
  end

  def delete_station(station)
    if @stations.index(station).nil?
      puts "Такой станции нет в маршрте"
    else
      @stations.delete(station)
    end
  end
end
