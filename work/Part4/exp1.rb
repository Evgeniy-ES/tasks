class Station

  attr_reader :tarins_on_station

  def initialize(station)
    @station = station
    @tarins_on_station = []
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

  def trains_info(type)
    count = 0
    @tarins_on_station.each do |train|
      count += 1 if train.type == type
    end
    puts "На станции #{count} #{type} поездов " if count > 0
  end
end

class Route
  attr_reader :stations
  def initialize(begin_station, end_station)
    @stations = [begin_station, end_station]
  end

  def add_station(name_station)
    if @stations.index(name_station).nil?
      @stations.insert(-2, name_station)
    else
      puts "Такая станция уже есть в маршрте"
    end
  end

  def delete_station(name_station)
    if @stations.index(name_station).nil?
      puts "Такой станции нет в маршрте"
    else
      @stations.delete(name_station)
    end
  end
end

class Train

  attr_accessor :speed
  attr_reader :number_of_wagon
  attr_reader :type

  def initialize(number, type, number_of_wagon)
    @number = number
    @type = type
    @number_of_wagon = number_of_wagon
    @speed = 0
    @route = []
    @station = ""
  end

  def stop
    @speed = 0
  end if

  def add_wagon
    if @speed == 0
      @number_of_wagon += 1
    else
      puts "Добавление вагона невозможно. Остановите поезд!"
    end
  end

  def delete_wagon
    if @speed == 0
      @number_of_wagon -= 1
    else
      puts "Отцепление вагона невозможно. Остановите поезд!"
    end
  end

  def route_train(route)
    @route = route.stations
    @station = @route[0]
  end

  def station_up
    if next_station.nil?
      puts "Движение вперёд невозможно, вы на конечной стации маршрута"
    else
      @station = next_station
    end
  end

  def station_down
    if previous_station.nil?
      puts "Движение назад невозможно, вы на начальной стации маршрута"
    else
      @station = previous_station
    end
  end

  def now_place
    puts "Текущая станция #{@station}"

    if previous_station.nil?
      puts "Текущая станция является началом маршрута"
    else
      puts "Предыдущая станция #{previous_station}"
    end

    if next_station.nil?
      puts "Текущая станция является концом маршрута"
    else
      puts "Следующая станция #{next_station}"
    end
  end

  def previous_station
    index_now_station = @route.index(@station)
    @route[index_now_station - 1] if index_now_station > 0
  end

  def next_station
    index_now_station = @route.index(@station)
    @route[index_now_station + 1] if index_now_station < @route.size - 1
  end

end
