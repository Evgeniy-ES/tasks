class Station
  require_relative 'instance_counter'
  extend InstanceCounter::ClassMethods
  include InstanceCounter::InstanceMethods

  @@all_stations_class = []
  @@count_class = 0
  attr_reader :tarins_on_station
  attr_reader :name

  def initialize(station)
    @name = station
    @@all_stations_class << self
    @tarins_on_station = []
  end

  def self.instances_class
    @@count_class = instances(@@all_stations_class)
    puts @@count_class
  end

  def metod_add
    @@count_class = register_instance(@@all_stations_class)
    puts @@count_class
  end

  def self.show_all_stations_metod
    @@all_stations_class.each {|station| puts station }
  end

  def arrive(train)       # прибытие поезда
      @tarins_on_station << train
  end

  def departure(train)       # отбытие поезда
    if @tarins_on_station.include?(train)
      @tarins_on_station.delete(train)
    else
      puts "Поезда с таким номером нет на станции"
    end
  end

  def trains_on_station
    count_cargo = 0
    count_passenger = 0
    @tarins_on_station.each do |train|
      count_cargo += 1 if train.type == :cargo
      count_passenger += 1 if train.type == :passenger
    end
    puts "На станции #{count_passenger} пассажиирских поездов " if count_passenger > 0
    puts "На станции #{count_cargo} грузовых поездов" if count_cargo > 0
  end
end
