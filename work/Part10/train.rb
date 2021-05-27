class Train
  require_relative 'all_modules'
  require_relative 'wagon'
  include Company
  include InstanceCounter
  include ValidateDate
  @@trains = []

  attr_accessor :speed, :route, :wagons
  attr_reader :current_station, :number, :type

  def self.all_trains
    @@trains.each_index { |x| msg_all_trains(x) }
  end

  def self.msg_all_trains(x)
    str0 = "Индекс #{x} поезд #{@@trains[x]}"
    puts str0 + ", количество вагонов  #{@@trains[x].wagons.size}"
  end

  def validate!
    msg01 = 'Поезд не создан. Формат номера поезда должен быть'
    msg0 = msg01 + ' ХХХ-ХХ или ХХХХХ где Х число/латинская буква'
    raise msg0 if @number !~ /^[a-z0-9]{3}-?[a-z0-9]{2}$/i
    msg01 = 'Поезд не создан. Тип поезда должен быть либо'
    msg0 = msg01 + ' :passenger либо :cargo'
    raise msg0 unless @type == :passenger || @type == :cargo
  end

  def initialize(number, type)
    @number = number
    @type = type
    validate
    return if valid? == false
    @speed = 0
    @wagons = []
    @@trains << self
  end

  def stop
    @speed = 0
  end

  def self.get_train(index)
    @@trains[index]
  end

  def self.all_wagons(index)
    @@trains[index].wagons.each_index { |wagon| yield(index, wagon) }
  end

  def all_wagons_train
    @wagons.each_index { |wagon| yield(wagon) }
  end

  def self.occupation_volume_in_wagon(index)
    str0 = 'Введен неккоректный индекс, добавление вагона прекращено'
    return puts str0 if index < 0 || index + 1 > @@trains.size
    stop_train(index)
    all_wagons(index) { |_index1, x| msg_wagon(index, x) }
    puts 'Введите индекс вагона который хотите заполнить'
    index_wagons = gets.chomp.to_i
    occupation_volume_in_wagon1(index, index_wagons)
  end

  def self.msg_wagon(index, x)
    str2 = "  #{@@trains[index].wagons[x].size},"
    str3 = " свободно #{@@trains[index].wagons[x].free_volume}"
    puts msg_wagon0(index, x) + str2 + str3
  end

  def self.msg_wagon0(index, x)
    str0 = "Индекс #{x} вагон типа #{@@trains[index].wagons[x].type}, всего"
    str1 = " #{@@trains[index].wagons[x].wagon_msg}"
    str0 + str1
  end

  def self.occupation_volume_in_wagon1(index, index_wagons)
    if index_wagons < 0 || index_wagons + 1 > @@trains[index].wagons.size
      puts 'Введен неккоректный индекс, заполнение вагона прекращено'
    else
      occupation_volume_in_wagon0(index, index_wagons)
    end
  end

  def self.occupation_volume_in_wagon0(index, index_wagons)
    volume_want = rec_volume_want(index)
    @@trains[index].wagons[index_wagons].occupation_volume(volume_want)
  end

  def self.rec_volume_want(index)
    if @@trains[index].type == :cargo
      puts 'Введите объем который хотите заполнить'
      gets.chomp.to_f
    else
      1
    end
  end

  def self.add_wagon(index)
    if index < 0 || index + 1 > @@trains.size
      puts 'Введен неккоректный индекс, добавление вагона прекращено'
    else
      add_wagon2(index)
    end
  end

  def self.add_wagon2(index)
    add_wagon0(index)
    enter_company
    wagon = add_wagon1(index)
    @@trains[index].wagons << wagon
    str0 = 'Вагон добавлен всего у поезда'
    puts str0 + " #{@@trains[index]} #{@@trains[index].wagons.size} вагонов"
  end

  def self.add_wagon1(index)
    work_volume = rec_work_volume(index)
    if @@trains[index].type == :cargo
      CargoWagon.new(name, work_volume)
    else
      PassengerWagon.new(name, work_volume)
    end
  end

  def self.rec_work_volume(index)
    if @@trains[index].type == :cargo
      puts 'Введите рабочий объем вагона'
    else
      puts 'Введите количество посадочных мест вагона'
    end
    gets.chomp.to_i
  end

  def self.add_wagon0(index)
    return if @@trains[index].speed.zero?
    str0 = 'Невозможно занимать место в вагонe на ходу,'
    str0 += ' поезд будет остановлен'
    puts "Поезд движется со скоростью #{@@trains[index].speed}. " + str0
    @@trains[index].speed = 0
  end

  def self.del_wagon(index)
    if index < 0 || index + 1 > @@trains.size
      puts 'Введен неккоректный индекс, добавление вагона прекращено'
    else
      del_wagon0(index)
    end
  end

  def self.del_wagon0(index)
    del_wagon2(index)
    del_wagon1(index)
  end

  def self.del_wagon2(index)
    stop_train(index) if @@trains[index].speed != 0
  end

  def self.del_wagon1(index)
    if @@trains[index].wagons.empty?
      puts 'У выбранного поезда нет вагонов'
    else
      del_wagon3(index)
    end
  end

  def self.del_wagon3(index)
    @@trains[index].wagons.delete_at(@@trains[index].wagons.size - 1)
    str0 = 'Вагон удален всего у поезда'
    puts str0 + " #{@@trains[index]} #{@@trains[index].wagons.size} вагонов"
  end

  def self.stop_train(index)
    str0 = 'Невозможно отцепить вагон на ходу, поезд будет остановлен'
    puts "Поезд движется со скоростью #{@@trains[index].speed}. " + str0
    @@trains[index].speed = 0
  end

  def route_train(route)
    @route = route
    @station = @route.stations[0]
    @station.arrive(self, @station)
  end

  def station_up
    return unless next_station
    @station.departure(self, @station)
    @station = next_station
    @station.arrive(self, @station)
  end

  def station_down
    return unless previous_station
    @station.departure(self, @station)
    @station = previous_station
    @station.arrive(self, @station)
  end

  def now_place
    puts "Текущая станция #{@station.station}"
    previous
    next_station0
  end

  def next_station0
    if next_station.nil?
      puts 'Текущая станция является концом маршрута'
    else
      puts "Следующая станция #{next_station.station}"
    end
  end

  def previous
    if previous_station.nil?
      puts 'Текущая станция является началом маршрута'
    else
      puts "Предыдущая станция #{previous_station.station}"
    end
  end

  protected

  def delete_wagon(index)
    if @@trains[index].wagons.empty?
      puts 'У выбранного поезда нет вагонов'
    else
      delete_wagon0(index)
    end
  end

  def delete_wagon0(index)
    @@trains[index].wagons.delete_at(@@trains[index].wagons.size - 1)
    str0 = 'Вагон удален всего у поезда'
    puts str0 + " #{@@trains[index]} #{@@trains[index].wagons.size} вагонов"
  end

  def previous_station
    index_now_station = @route.stations.index(@station)
    @route.stations[index_now_station - 1] if index_now_station > 0
  end

  def next_station
    index_now_station = @route.stations.index(@station)
    return if index_now_station < @route.stations.size - 1
    @route.stations[index_now_station + 1]
  end
end
