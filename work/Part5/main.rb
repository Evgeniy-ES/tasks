require_relative 'station'
require_relative 'menu'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'

include Menu  # методы связанные с выводом вопросов, были вынесены в отдельный модуль, для лучшей читаемости кода


def menu      # главное меню, тут выбираются объекты для дальнейшей работы
  i = false
  while i == false
    want = menu_main
    case want
    when 0
      i = true
    when 1
      work_with_stations
    when 2
      menu_routes
    when 3
      work_with_trains
    end
  end
end

def work_with_trains
  i = false
  while i == false
    want = menu_train
    case want
    when 0
      i = true
    when 1
      create_train
    when 2
      add_wagon
    when 3
      delete_wagon
    when 4
      movie_train
    end
  end
end

def movie_train
  i = false
  while i == false
    puts "Хотите передвинуть поезд нажмите 1, хотите выйти нажмите 0"
    want = gets.chomp.to_i
    if want == 0
      i = true
    else
      show_all_trains
      num_train = find_num("", @all_trains.size, nil, "поезда")
      puts "Хотите передвинуть поезд вперед по маршруту нажмите 1, назад любую другую цифру"
      want = gets.chomp.to_i
      if want == 1
        @all_trains[num_train].station_up
      else
        @all_trains[num_train].station_down
      end
    end
  end
end

def create_train
    puts "Введите номер поезда"
    num_train = gets.chomp.to_i
    puts "Введите 0 если поезд грузовой, если пассажирский, то любую другую цифру"
    type_train_num = gets.chomp.to_i

    new_train = "train" + @all_trains.size.to_s
    puts "Введите 0 #{new_train}"
    if  type_train_num == 0
      new_train = CargoTrain.new(num_train)
    else
      new_train = PassengerTrain.new(num_train)
    end
    @all_trains << new_train
end

def show_all_trains
  puts "------------------Все поезда-----------------------"
  i = 0
  @all_trains.each do |train|
    if train.station == ""
      station = ""
    else
      station = train.station.station
    end
    puts "#{i} Поезд номер #{train.number} тип #{train.type} количество вагонов #{train.number_of_wagon.size}, станция  #{station}"
    i += 1
  end
  puts "=================================================="
end

def delete_wagon
  i = false
  while i == false
    puts "Хотите отцепить вагон от поезда нажмите 1, хотите выйти нажмите 0"
    want = gets.chomp.to_i
    if want == 0
      i = true
    else
      show_all_trains
      num_train = find_num("", @all_trains.size, nil, "поезда")
      @all_trains[num_train].delete_wagon
    end
  end
end

def add_wagon
  i = false
  while i == false
    puts "Хотите добавить вагон к поезду нажмите 1, хотите выйти нажмите 0"
    want = gets.chomp.to_i

    if want == 0
      i = true
    else
      show_all_trains
      num_train = find_num("", @all_trains.size, nil, "поезда")
      i1 = false
      while i1 == false
        puts "Для добавления грузового вагона нажмите 1, пассажирского любую другую цифру, для выхода нажмите 0"
        want = gets.chomp.to_i
        case want
        when 0
          i1 = true
        when 1
          cargo_wagon = CargoWagon.new
          @all_trains[num_train].add_wagon(cargo_wagon)
        else
          passenger_wagon = PassengerWagon.new
          @all_trains[num_train].add_wagon(passenger_wagon)
        end
      end
    end
  end
end

def menu_routes
  i = false
  while i == false
    want = menu_routes0
    case want
    when 0
      i = true
    when 1
      create_route
    end
  end
end

def create_route
show_all_station
  if  @all_stations.size < 2
    puts "Для создания маршрута необходимо минимум две станции, создайте необходимое количество"
    create_station
  else
    num0 = find_num("начальной", @all_stations.size, nil, "станции")
    num1 = find_num("конечной", @all_stations.size, num0, "станции")
    route = Route.new(@all_stations[num0], @all_stations[num1])
    i = false
    while i == false
      puts "Хотите добавить станцию в маршрут нажмите 1, хотите выйти нажмите 0"
      want = gets.chomp.to_i
      if want == 0
        i = true
      else
        show_all_station
        if @all_stations.size < 3
          puts "Станций всего две, необходимо сначало создать станцию, а потом добавить её в маршрут"
          create_station
          num0 = find_num("промежуточной", @all_stations.size, nil)
          route.add_station(@all_stations[num0])
        end
      end
    end
  end

  puts "Для присвоения маршрута поезду нажмите 1. Для выхода нажмите любую другую цифру"
  want = gets.chomp.to_i
  if want == 1
    show_all_trains
    num_train = find_num("", @all_trains.size, nil, "поезда")
    @all_trains[num_train].route_train(route)
  end

end

def create_station
    puts "Введите название станции"
    want = gets.chomp.to_s
    new_station = "station"+@all_stations.size.to_s
    new_station = Station.new(want)
    @all_stations << new_station
end

def show_all_station
  puts "------------------Все станции-----------------------"
  i = 0
  @all_stations.each do |station|
    puts "#{i} Станция #{station.station}"
    i += 1
  end
  puts "=================================================="
end



def work_with_stations
  i = false
  while i == false
    want = menu_station
    case want
    when 0
      i = true
    when 1
      create_station
    when 2
      show_all_station
    when 3
      show_trains_on_station
    end
  end
end

def show_trains_on_station
  show_all_station
  num = find_num("необходимой", @all_stations.size, nil, "станции")
  puts "#{@all_stations[num].tarins_on_station}"
end

@all_stations = []
@all_trains = []
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
