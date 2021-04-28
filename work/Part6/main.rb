require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'all_modules'

include Menu  # методы связанные с выводом вопросов, были вынесены в отдельный модуль, для лучшей читаемости кода


def menu      # главное меню, тут выбираются объекты для дальнейшей работы
  i = false
  while i == false
    want = get_menu_main
    case want
    when 0
      i = true
    when 1
      work_with_stations
    when 2
      work_with_trains
    when 3
      menu_routes
    end
  end
end

def work_with_trains
  i = false
  while i == false
    want = get_menu_train
    case want
    when 0
      i = true
    when 1
      create_train
    when 2
      add_wagon
    when 3
      del_wagon_main
    when 4
      movie_train
    when 5
      Train.find
    when 6
      add_route_train
    end
  end
end

def movie_train
  Train.all_trains
  puts "Введите индекс поезда укоторый хотите подвинуть по маршруту"
  train_index = gets.chomp.to_i
  train = Train.get_train(train_index)
  if train.nil?
    puts "Вы ввели неправильный индекс"
  else
    puts "Станции маршрута выбранного поезда:"
    train.route.stations.each { |x| puts x.name}
    i = false
    while i == false
      puts "Введите 0 если хотите выйти, 1 подвинуть поезд вперед, 2 подвинуть поезд назад"
      want = gets.chomp.to_i
      case want
      when 0
        i = true
      when 1
        train.station_up
      when 2
        train.station_down
      end
    end
  end
end

def add_route_train
  Train.all_trains
  puts "Введите индекс поезда к которому хотите добавить вагон"
  train_index = gets.chomp.to_i
  train = Train.get_train(train_index)
  if train.nil?
    puts "Вы ввели неправильный индекс"
  else
    puts "Маршруты:"
    Route.all
    puts "Выберите индекс маршрута"
    route_index = gets.chomp.to_i
    route = Route.get_route(route_index)
    if route.nil?
      puts "Вы ввели неправильный индекс"
    else
      train.route_train(route)
      Train.change_train(train_index, train)
    end
  end
end

def create_train
    puts "Введите номер поезда"
    num_train = gets.chomp.to_i
    puts "Введите 0 если поезд грузовой, если пассажирский, то любую другую цифру"
    type_train_num = gets.chomp.to_i
    if  type_train_num == 0
      CargoTrain.new(num_train)
    else
      PassengerTrain.new(num_train)
    end
end

def add_wagon
    Train.all_trains
    puts "Введите индекс поезда к которому хотите добавить вагон"
    index = gets.chomp.to_i
    Train.add_wagon(index)
end

def del_wagon_main
    Train.all_trains
    puts "Введите индекс поезда у которого хотите отцепить вагон"
    index = gets.chomp.to_i
    Train.del_wagon(index)
end

def work_with_stations
  i = false
  while i == false
    want = get_menu_station
    case want
    when 0
      i = true
    when 1
      create_station
    when 2
      Station.all
    when 3
      show_trains_on_station
    when 4
      show_type_trains_on_station
    end
  end
end

def show_type_trains_on_station
  Station.all
  puts "Выберите индекс станци"
  station_index = gets.chomp.to_i
  station = Station.get_station(station_index)
  if station.nil?
    puts "Вы ввели неправильный индекс"
  else
puts station
    puts "Введите 0 если хотите посмотреть грузвые поезда, 1 если пассажирские"
    want = gets.chomp.to_i
    if want == 1
      type = :passenger
    else
      type = :cargo
    end

    station.trains_on_station_by_type(type)
  end
end

def show_trains_on_station
  Station.all
  puts "Выберите индекс станци"
  station_index = gets.chomp.to_i
  station = Station.get_station(station_index)
  if station.nil?
    puts "Вы ввели неправильный индекс"
  else
    station.trains_on_station
  end
end

def create_station
    Station.all
    puts "Введите название станции"
    want = gets.chomp.to_s
    Station.new(want)
end

def menu_routes
  i = false
  while i == false
    want = get_menu_route
    case want
    when 0
      i = true
    when 1
      create_route
    when 2
      add_station_in_route
    end
  end
end

def add_station_in_route
  Route.all
  puts "Выберите индекс маршрута"
  route_index = gets.chomp.to_i
  route = Route.get_route(route_index)
  if route.nil?
    puts "Вы ввели неправильный индекс"
  else
    puts "Станции маршрута:"
    route.stations.each { |x| puts x.name}
    Station.all
    puts "Выберите индекс станции"
    station_index = gets.chomp.to_i
    station = Station.get_station(station_index)
    if station.nil?
      puts "Вы ввели неправильный индекс"
    else
      route.add_station(station)
      Route.change_route(route_index, route)
    end
  end
end

def create_route
    Station.all
    puts "Выберите индекс начальной станции"
    begin_station_index = gets.chomp.to_i
    begin_station = Station.get_station(begin_station_index)
    if begin_station.nil?
      puts "Вы ввели неправильный индекс"
    else
      puts "Выберите индекс конечной станции"
      end_station_index = gets.chomp.to_i
      end_station = Station.get_station(begin_station_index)
      if end_station.nil?
        puts "Вы ввели неправильный индекс"
      else
        r = Route.new(begin_station,end_station)
        puts "Маршрут #{r} создан"
      end
    end
end


#---- тестовые данные ------
train1 = CargoTrain.new(0)
Train.test_add_wagon
st0 = Station.new("station0")
st1 = Station.new("station1")
st2 = Station.new("station2")
st3 = Station.new("station3")
r1 = Route.new(st0,st2)
r1.add_station(st1)
#---- /тестовые данные ------

i = false
while i == false
  puts 'Если вы хотите работать с программой нажмите - 1, нет - 0'
  want = gets.chomp.to_i
  if want == 0
    i = true
  else
    menu
  end
end
