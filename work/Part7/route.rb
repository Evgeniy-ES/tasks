class Route
  include InstanceCounter

  attr_accessor :stations

  @@all_routes = []

  def self.all
    @@all_routes.each_index { |x| puts " Индекс #{x} маршрут #{@@all_routes[x]}"}
  end

  def self.get_route(index)
    @@all_routes[index]
  end

  def validate!
    raise if @stations.size < 2
  end

  def initialize(station1, station2)
    begin
      @stations = [station1, station2]
      validate!
      @@all_routes << self
      self.register_instance
    rescue
      puts "Маршрут не создан. В маршруте должно содержаться как минимум 2 станции"
    end

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
