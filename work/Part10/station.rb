class Station
  require_relative 'all_modules'
  require_relative 'train'
  include InstanceCounter
  include Validation

  attr_reader :name, :trains_on_station

  validate :name, :presence
  validate :name, :format, /[a-zа-я]{2}/
  validate :name, :type, :String

  @@stations = []

  def self.all
    @@stations.each_index { |x| view_stations(x) }
  end

  def self.view_stations(x)
    s0 = " Индекс #{x} станция #{@@stations[x]},"
    puts s0 + " имя станции  #{@@stations[x].name}"
  end

  def self.get_station(index)
    @@stations[index]
  end

  #def validate!
  #  msg = 'В названии станции должно содержаться как минимум 2 буквы'
  #  raise msg if @name !~ /[a-zа-я]{2}/
#  end

  def initialize(station)
    @name = station
    validate
    return if valid? == false
    @@stations << self
    @trains_on_station = []
    register_instance
  end

  def arrive(train, station)
    @trains_on_station << train
    puts "Поезд с номером #{train.number} прибыл на станцию #{station.name}"
  end

  def departure(train, station)
    if @trains_on_station.include?(train)
      @trains_on_station.delete(train)
      puts "Поезд с номером #{train.number} отбыл со станции #{station.name}"
    else
      puts 'Поезда с таким номером нет на станции'
    end
  end

  def trains_on_station_by_type(type)
    trains_type = @trains_on_station.filter { |train| train.type == type }
    puts trains_type
  end

  def train_on_station
    @trains_on_station.each { |train| yield(train) }
  end

  def self.info_about_stations
    @@stations.each_index do |index_station|
      puts " Имя станции  #{@@stations[index_station].name}"
      if !@@stations[index_station].trains_on_station.empty?
        display_train(@@stations[index_station].trains_on_station)
      else
        puts 'На станции нет поездов.'
      end
    end
  end

  def self.display_train(trains_on_station_for_method)
    puts 'На станции:'
    trains_on_station_for_method.each do |train|
      display_train0(train)
    end
  end

  def self.display_train0(train)
    puts " - Поезд тип #{train.type}, номер #{train.number}," +
         + " количество вагонов #{train.wagons.size}"
    return if train.wagons.empty?
    puts 'Вагоны поезда:'
    train.all_wagons_train { |x| puts msg1(x) }
    puts ' --------------------------- '
  end

  def msg1(x)
    msg10(x) + msg11(x)
  end

  def msg10(x)
    s0 = "Вагон номер #{x} вагон типа #{train.wagons[x].type},"
    s1 = " всего #{train.wagons[x].wagon_msg}"
    s0 + s1
  end

  def msg11(x)
    s2 = " #{train.wagons[x].size}, свободно"
    s3 = " #{train.wagons[x].free_volume}"
    s2 + s3
  end
end
