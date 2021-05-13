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
    @@trains.each_index { |x| puts " Индекс #{x} поезд #{@@trains[x]}, количество вагонов  #{@@trains[x].wagons.size}"}
  end

  def validate!
    raise "Поезд не создан. Формат номера поезда должен быть ХХХ-ХХ или ХХХХХ где Х число/латинская буква" if @number !~ /^[a-z0-9]{3}-?[a-z0-9]{2}$/i
    raise "Поезд не создан. Тип поезда должен быть либо  :passenger либо :cargo" unless @type == :passenger || @type == :cargo
  end

  def initialize(number, type)
      @number = number
      @type = type
      validate
      if self.valid? == true
        @speed = 0
        @wagons = []
        @@trains << self
      end
  end

  def stop
    @speed = 0
  end if

  def self.get_train(index)
    @@trains[index]
  end

  def self.all_wagons(index, &block)
    @@trains[index].wagons.each_index { |wagon| block.call(index, wagon) }
  end

  def all_wagons_train(&block)
    @wagons.each_index { |wagon| block.call(wagon) }
  end

  def self.occupation_volume_in_wagon(index)
    if index < 0 || index + 1 > @@trains.size
      return puts "Введен неккоректный индекс, добавление вагона прекращено"
    else
      if @@trains[index].speed != 0
        puts "Поезд движется со скоростью #{@@trains[index].speed}. Невозможно добавить вагон на ходу, поезд будет остановлен"
        @@trains[index].speed = 0
      end

      self.all_wagons(index) { |index, x| puts " Индекс #{x} вагон типа #{@@trains[index].wagons[x].type}, всего #{@@trains[index].wagons[x].wagon_msg} #{@@trains[index].wagons[x].size}, свободно #{@@trains[index].wagons[x].free_volume}"}
      puts "Введите индекс вагона который хотите заполнить"
      index_wagons = gets.chomp.to_i

      if index_wagons < 0 || index_wagons + 1 > @@trains[index].wagons.size
        return puts "Введен неккоректный индекс, заполнение вагона прекращено"
      else
        if @@trains[index].type == :cargo
          puts "Введите объем который хотите заполнить"
          volume_want = gets.chomp.to_f
          @@trains[index].wagons[index_wagons].occupation_volume(volume_want)
        else
          @@trains[index].wagons[index_wagons].occupation_volume
        end
      end
    end
  end

  def self.add_wagon(index)
    if index < 0 || index + 1 > @@trains.size
      return puts "Введен неккоректный индекс, добавление вагона прекращено"
    else
      if @@trains[index].speed != 0
        puts "Поезд движется со скоростью #{@@trains[index].speed}. Невозможно занимать место в вагонe на ходу, поезд будет остановлен"
        @@trains[index].speed = 0
      end
      name = self.enter_company
      if @@trains[index].type == :cargo
        puts "Введите рабочий объем вагона"
        work_volume = gets.chomp.to_i
        wagon = CargoWagon.new(name, work_volume)
      else
        puts "Введите количество посадочных мест вагона"
        work_place = gets.chomp.to_i
        wagon = PassengerWagon.new(name, work_place)
      end
      @@trains[index].wagons << wagon
      puts "Вагон добавлен всего у поезда #{@@trains[index]} #{@@trains[index].wagons.size} вагонов"
    end
  end

  def self.del_wagon(index)
    if index < 0 || index + 1 > @@trains.size
      return puts "Введен неккоректный индекс, добавление вагона прекращено"
    else
      if @@trains[index].speed != 0
        puts "Поезд движется со скоростью #{@@trains[index].speed}. Невозможно отцепить вагон на ходу, поезд будет остановлен"
        @@trains[index].speed = 0
      end
      if @@trains[index].wagons.size < 1
        puts "У выбранного поезда нет вагонов"
      else
        @@trains[index].wagons.delete_at(@@trains[index].wagons.size - 1)
        puts "Вагон удален всего у поезда #{@@trains[index]} #{@@trains[index].wagons.size} вагонов"
      end
    end
  end

  def route_train(route)
    @route = route
    @station = @route.stations[0]
    @station.arrive(self)
  end

  def station_up
    return unless next_station
    @station.departure(self)
    @station = next_station
    @station.arrive(self)
  end

  def station_down
    return unless previous_station
    @station.departure(self)
    @station = previous_station
    @station.arrive(self)
  end

  def now_place
    puts "Текущая станция #{@station.station}"

    if previous_station.nil?
      puts "Текущая станция является началом маршрута"
    else
      puts "Предыдущая станция #{previous_station.station}"
    end

    if next_station.nil?
      puts "Текущая станция является концом маршрута"
    else
      puts "Следующая станция #{next_station.station}"
    end
  end


  protected
  # непосредственное удалени вагонов и перемещение поезда по станциям не должно выполняться без дополнительных проверок
  def delete_wagon(index)
    if @@trains[index].wagons.size < 1
      puts "У выбранного поезда нет вагонов"
    else
      @@trains[index].wagons.delete_at(@@trains[index].wagons.size - 1)
      puts "Вагон удален всего у поезда #{@@trains[index]} #{@@trains[index].wagons.size} вагонов"
    end
  end

  def previous_station
    index_now_station = @route.stations.index(@station)
    @route.stations[index_now_station - 1] if index_now_station > 0
  end

  def next_station
    index_now_station = @route.stations.index(@station)
    @route.stations[index_now_station + 1] if index_now_station < @route.stations.size - 1
  end

end
