class RailsRoad
  require_relative 'all_modules'
  require_relative 'station'
  require_relative 'route'
  require_relative 'train'
  require_relative 'passenger_train'
  require_relative 'cargo_train'
  require_relative 'wagon'
  require_relative 'passenger_wagon'
  require_relative 'cargo_wagon'

  include Menu
  include ValidateDate

  def menu
    i = false
    while i == false
      want = menu_main
      if want.zero?
        i = true
      else
        menu0(want)
      end
    end
  end

  def menu0(want)
    case want
    when 1
      work_with_stations
    when 2
      work_with_trains
    when 3
      menu_routes
    end
  end

  def work_with_trains
    i = false
    while i == false
      want = menu_train
      if want.zero?
        i = true
      else
        work_with_trains0(want)
      end
    end
  end

  def work_with_trains0(want)
    if want == 1
      create_train
    else
      work_with_trains1(want)
    end
  end

  def work_with_trains1(want)
    if want == 2
      add_wagon
    else
      work_with_trains2(want)
    end
  end

  def work_with_trains2(want)
    if want == 3
      del_wagon_main
    else
      work_with_trains3(want)
    end
  end

  def work_with_trains3(want)
    if want == 4
      movie_train
    else
      work_with_trains4(want)
    end
  end

  def work_with_trains4(want)
    if want == 5
      Train.find
    else
      work_with_trains5(want)
    end
  end

  def work_with_trains5(want)
    if want == 6
      add_route_train
    else
      use_place_in_wagon
    end
  end

  def movie_train
    train = determination_trains
    if train.nil?
      puts 'Вы ввели неправильный индекс'
    else
      movie_train0(train)
    end
  end

  def movie_train0(train)
    puts 'Станции маршрута выбранного поезда:'
    train.route.stations.each { |x| puts x.name }
    i = false
    while i == false
      puts 'Введите 0 если хотите выйти, 1 подвинуть поезд вперед,' +
           + ' 2 подвинуть поезд назад'
      want = gets.chomp.to_i
      i = movie_train1(want, train)
    end
  end

  def movie_train1(want, train)
    i = false
    case want
    when 0
      i = true
    when 1
      train.station_up
    when 2
      train.station_down
    end
    i
  end

  def add_route_train
    train = determination_trains
    if train.nil?
      puts 'Вы ввели неправильный индекс'
    else
      add_route_train0(train)
    end
  end

  def add_route_train0(train)
    puts 'Маршруты:'
    route = determination_route
    if route.nil?
      puts 'Вы ввели неправильный индекс'
    else
      train.route_train(route)
    end
  end

  def determination_trains
    Train.all_trains
    puts 'Введите индекс поезда к которому хотите добавить маршрут'
    train_index = gets.chomp.to_i
    Train.get_train(train_index)
  end

  def create_train
    type_train_num = type_train
    train = if type_train_num[1].zero?
              CargoTrain.new(type_train_num[0])
            else
              PassengerTrain.new(type_train_num[0])
            end
    return if train.nil?
    puts 'Поезд создан' if train.valid?
  end

  def type_train
    puts 'Введите номер поезда'
    num_train = gets.chomp
    puts 'Введите 0 если поезд грузовой, если пассажирский,' +
         + 'то любую другую клавишу'
    type_train_num = gets.chomp.to_i
    [num_train, type_train_num]
  end

  def add_wagon
    Train.all_trains
    puts 'Введите индекс поезда к которому хотите добавить вагон'
    index = gets.chomp.to_i
    Train.add_wagon(index)
  end

  def use_place_in_wagon
    Train.all_trains
    puts 'Введите индекс поезда, в вагонах которого хотите использовать место'
    index = gets.chomp.to_i
    Train.occupation_volume_in_wagon(index)
  end

  def del_wagon_main
    Train.all_trains
    puts 'Введите индекс поезда у которого хотите отцепить вагон'
    index = gets.chomp.to_i
    Train.del_wagon(index)
  end

  def work_with_stations
    i = false
    while i == false
      want = menu_station
      i = action_with_stations(want)
    end
  end

  def action_with_stations(want)
    if want.zero?
      true
    else
      action_with_stations0(want)
      false
    end
  end

  def action_with_stations0(want)
    if want == 1
      create_station
    else
      action_with_stations1(want)
    end
  end

  def action_with_stations1(want)
    if want == 2
      Station.all
    else
      action_with_stations2(want)
    end
  end

  def action_with_stations2(want)
    if want == 3
      show_trains_on_station
    else
      action_with_stations3(want)
    end
  end

  def action_with_stations3(want)
    if want == 4
      show_type_trains_on_station
    else
      Station.info_about_stations
    end
  end

  def show_type_trains_on_station
    station = determination_station(' ')
    if station.nil?
      puts 'Вы ввели неправильный индекс'
    else
      show_type_trains_on_station0(station)
    end
  end

  def show_type_trains_on_station0(station)
    puts station
    puts 'Введите 0 если хотите посмотреть грузвые поезда, 1 если пассажирские'
    want = gets.chomp.to_i
    if want == 1
      station.trains_on_station_by_type(:passenger)
    else
      station.trains_on_station_by_type(:cargo)
    end
  end

  def show_trains_on_station
    station = determination_station(' ')
    if station.nil?
      puts 'Вы ввели неправильный индекс'
    else
      station.train_on_station { |x| puts msg_train0(x) }
    end
  end

  def msg_train0(x)
    "Поезд тип #{x.type}, номер #{x.number}," +
      + "количество вагонов #{x.wagons.size}"
  end

  def create_station
    Station.all
    puts 'Введите название станции'
    want = gets.chomp.to_s
    station = Station.new(want)
    return if station.nil?
    puts 'Станция создана' if station.valid?
  end

  def menu_routes
    i = false
    while i == false
      want = menu_route
      i = action_with_route(want)
    end
  end

  def action_with_route(want)
    i = false
    case want
    when 0
      i = true
    when 1
      create_route
    when 2
      add_station_in_route
    end
    i
  end

  def add_station_in_route
    route = determination_route
    if route.nil?
      puts 'Вы ввели неправильный индекс'
    else
      add_station_in_route0(route)
    end
  end

  def add_station_in_route0(route)
    puts 'Станции маршрута:'
    route.stations.each { |x| puts x.name }
    station = determination_station(' ')
    if station.nil?
      puts 'Вы ввели неправильный индекс'
    else
      route.add_station(station)
    end
  end

  def determination_route
    Route.all
    puts 'Выберите индекс маршрута'
    route_index = gets.chomp.to_i
    Route.get_route(route_index)
  end

  def create_route
    begin_station = determination_station('начальной')
    if begin_station.nil?
      puts 'Вы ввели неправильный индекс'
    else
      end_station = determination_station('конечной')
      check_end_station_and_create_route(begin_station, end_station)
    end
  end

  def determination_station(text = '')
    Station.all if text != 'конечной'
    puts "Выберите индекс #{text} станции"
    station_index = gets.chomp.to_i
    Station.get_station(station_index)
  end

  def check_end_station_and_create_route(begin_station, end_station)
    if end_station.nil?
      puts 'Вы ввели неправильный индекс'
    else
      r = Route.new(begin_station, end_station)
      unless r.nil?
        puts "Маршрут #{r} создан" if r.valid?
      end
    end
  end

  def test_data
    st0 = Station.new('station0')
    st2 = Station.new('station1')
    st1 = Station.new('station2')
    Station.new('station3')
    r1 = Route.new(st0, st2)
    r1.add_station(st1)
    # ---- /test data ------
  end

  def initial_progam0
    i = false
    while i == false
      puts 'Если вы хотите работать с программой нажмите - 1, нет - 0'
      want = gets.chomp.to_i
      if want.zero?
        i = true
      else
        menu
      end
    end
  end

  def initial_progam
    test_data
    initial_progam0
  end
end
