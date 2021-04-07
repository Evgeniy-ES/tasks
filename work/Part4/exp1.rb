class Station

  attr_reader :tarins_on_station
  attr_reader :station

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
  def initialize(station1, station2)
    @stations = [station1, station2]
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

  def previous_station
    index_now_station = @route.stations.index(@station)
    @route.stations[index_now_station - 1] if index_now_station > 0
  end

  def next_station
    index_now_station = @route.stations.index(@station)
    @route.stations[index_now_station + 1] if index_now_station < @route.stations.size - 1
  end

end
