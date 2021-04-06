class Station
  def initialize(name)
    @name = name
    @tarins_on_station = {}
  end

  def arrive(num_train, type_tain)       # прибытие поезда
      @tarins_on_station[num_train] = type_tain
  end

  def departure(num_train)       # отбытие поезда
    if @tarins_on_station[num_train].nil?
      puts "Поезда с таким номером нет на станции"
    else
      @tarins_on_station.delete(num_train)
    end
  end

  def all_trains
    @tarins_on_station.each_key {| key | puts key }
  end

  def trains_info
    q_cargo = 0
    q_passenger = 0
    @tarins_on_station.each do |key, type_tain|
      q_cargo += 1 if type_tain == "cargo"
      q_passenger += 1 if type_tain == "passenger"
    end
    puts "На станции #{q_cargo} грузовых поездов" if q_cargo > 0
    puts "На станции #{q_passenger} пассажирских поездов" if q_passenger > 0
  end
end

class Route
  def initialize(begin_station, end_station)
    @array_stations = []
    @array_stations[0] = begin_station
    @array_stations[1] = end_station
  end

  def add_station(name_station)
    if a.index(name_station).nil?
      end_station = @array_stations[@array_stations.size - 1]
      @array_stations.delete_at(@array_stations.size - 1)
      @array_stations << name_station
      @array_stations << end_station
    else
      puts "Такая станция уже есть в маршрте"
    end

  end

  def delete_station(name_station)
    if a.index(name_station).nil?
      puts "Такой станции нет в маршрте"
    else
      @array_stations.delete(name_station)
    end
  end

  def all_stations
    @array_stations.each { |station| puts station }
  end
end

class Train

  attr_accessor :speed
  attr_reader :number_of_wagon

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

  def route_tarin(route)
    @route = route
    @station = @route[0]
  end

  def station_up
    index_now_station = @route.index(@station)
    if index_now_station < @route.size - 1
      @station = @route[index_now_station + 1]
    else
      puts "Движение вперёд невозможно, вы на конечной стации маршрута"
    end
  end

  def station_down
    index_now_station = @route.index(@station)
    if index_now_station > 0
      @station = @route[index_now_station - 1]
    else
      puts "Движение назад невозможно, вы на начальной стации маршрута"
    end
  end

  def now_place
    puts "Текущая станция #{@station}"
    index_now_station = @route.index(@station)
    if index_now_station > 0
      puts "Предыдущая станция #{@route[index_now_station - 1]}"
    else
      puts "Текущая станция является началом маршрута"
    end

    if index_now_station < @route.size - 1
      puts "Следующая станция #{@route[index_now_station + 1]}"
    else
      puts "Текущая станция является концом маршрута"
    end
  end

end
