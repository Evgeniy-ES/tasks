class Train
  require_relative 'all_modules'
  include Company
  include InstanceCounter
  @@trains = []

  attr_accessor :speed, :route, :wagon
  attr_reader :current_station, :number, :type

  def self.all_trains
    @@trains.each_index { |x| puts " Индекс #{x} поезд #{@@trains[x]}, количество вагонов  #{@@trains[x].wagon.size}"}
  end

  def validate!
    raise puts "Формат номера поезда ХХХ-ХХ или ХХХХХ где Х число/латинская буква" if @number !~ /^[a-z0-9]{3}-?[a-z0-9]{2}$/i
    if @type == :passenger || @type == :cargo
      @type = type
    else
      raise puts "Тип поезда должен быть либо  :passenger либо :cargo"
    end
  end

  def initialize(number, type)
    begin
      @number = number
      @type = type
      @speed = 0
      @wagon = []
      @@trains << self
      validate!
    rescue
      puts "Введите корректные данные"
    end
  end

  def stop
    @speed = 0
  end if

  def self.get_train(index)
    @@trains[index]
  end

  def self.add_wagon(index)
    if index < 0 || index + 1 > @@trains.size
      return puts "Введен неккоректный индекс, добавление вагона прекращено"
    else
      if @@trains[index].speed != 0
        puts "Поезд движется со скоростью #{@@trains[index].speed}. Невозможно добавить вагон на ходу, поезд будет остановлен"
        @@trains[index].speed = 0
      end
      name = self.enter_company

      if @@trains[index].type == :cargo
        wagon = CargoWagon.new(name)
      else
        wagon = PassengerWagon.new(name)
      end
      @@trains[index].wagon << wagon
      puts "Вагон добавлен всего у поезда #{@@trains[index]} #{@@trains[index].wagon.size} вагонов"
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
      if @@trains[index].wagon.size < 1
        puts "У выбранного поезда нет вагонов"
      else
        @@trains[index].wagon.delete_at(@@trains[index].wagon.size - 1)
        puts "Вагон удален всего у поезда #{@@trains[index]} #{@@trains[index].wagon.size} вагонов"
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
    if @@trains[index].wagon.size < 1
      puts "У выбранного поезда нет вагонов"
    else
      @@trains[index].wagon.delete_at(@@trains[index].wagon.size - 1)
      puts "Вагон удален всего у поезда #{@@trains[index]} #{@@trains[index].wagon.size} вагонов"
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
