class Train
  require_relative 'company'
  require_relative 'instance_counter'

  include Company
  extend InstanceCounter::ClassMethods
  include InstanceCounter::InstanceMethods

  @@trains = []
  @@count_class = 0
  attr_accessor :speed
  attr_accessor :route
  attr_reader :number_of_wagon
  attr_reader :station
  attr_reader :number
  attr_reader :manufacturer

  def initialize(number, company)
    @number = number
    @speed = 0
    @route = []
    @station = ""
    @number_of_wagon = []
    @manufacturer = name_company(company)
  end

  def self.instances_class
    @@count_class = instances(@@trains)
    puts @@count_class
  end

  def metod_add
    @@count_class = register_instance(@@trains)
    puts @@count_class
  end

  def self.find#(number)
    puts "Введите номер поезда"
    find_num = gets.chomp.to_i
    @@trains.each do |train|
      if train.number == find_num
        puts "////////////////////////////////////"
        puts "Поезд номер #{train.number}"
        puts "Поезд тип #{train.type}"
        puts "Производитель #{train.manufacturer}"
        puts "////////////////////////////////////"
        return
      end
    end
    puts "////////////////////////////////////"
    puts "Поезда с таким номером не существует"
    puts "////////////////////////////////////"
  end

  def stop
    @speed = 0
  end if

  def add_wagon(wagon)
    if @speed == 0
      if self.type == wagon.type
        @number_of_wagon << wagon
      else
        puts "Добавление вагона невозможно. Не совпадают типы поезда и вагона!"
      end
    else
      puts "Добавление вагона невозможно. Остановите поезд!"
    end
  end

  def delete_wagon
    if @speed == 0
      delete_wagon!
    else
      puts "Отцепление вагона невозможно. Остановите поезд!"
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
    @station.arrive(self)
    @station = next_station
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
  def delete_wagon!
    index_last_wagon = self.number_of_wagon.size
    if index_last_wagon > 0
      self.number_of_wagon.delete_at(index_last_wagon - 1)
    else
      puts "Удаление невозможно. У поезда нет вагонов."
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
