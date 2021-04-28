class Route
  include InstanceCounter

  attr_accessor :stations

  @@all_routes = []

  def self.all
    puts "Все маршруты"
    @@all_routes.each_index { |x| puts " Индекс #{x} маршрут #{@@all_routes[x]}"}
  end

  def self.change_route(index, route)
    @@all_routes[index] = route
  end

  def self.get_route(index)
    @@all_routes[index]
  end

  def initialize(station1, station2)
    @stations = [station1, station2]
    @@all_routes << self
    self.register_instance
  end


  def add_station(station)
    if @stations.index(station).nil?
      @stations.insert(-2, station)
    else
      puts "Такая станция уже есть в маршруте"
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
