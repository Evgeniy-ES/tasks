module Menu
  
  def get_menu_station
    puts "--------------------Меню станции----------------------------"
    puts "Если вы хотите создать станцию нажмите - 1"
    puts "Если вы хотите посмотреть названия всех станций нажмите - 2"
    puts "Если вы хотите посмотреть все поезда на станции нажмите - 3"
    puts "Для выхода из меню, нажмите - 0"
    puts "============================================================"
    gets.chomp.to_i
  end

  def get_menu_main
    puts "---------------------Меню-----------------------"
    puts "Если вы хотите работать со станциями  нажмите  1"
    puts "Если вы хотите работать с  маршрутами нажмите  2"
    puts "Если вы хотите работать с  поездами   нажмите  3"
    puts "Для выхода из меню, нажмите - 0"
    puts "================================================"
    gets.chomp.to_i
  end

  def get_menu_routes
    puts "--------------------Меню маршрута---------------------------"
    puts "Если вы хотите создать маршрут нажмите - 1"
    puts "Для выхода из меню, нажмите - 0"
    puts "============================================================"
    gets.chomp.to_i
  end

  def find_num(pozition_station, quantity_stations, num_begin, our_object)
    i = false
    while i == false
      puts "Выбирете номер #{pozition_station} #{our_object}"
      num = gets.chomp.to_i
      if num >= 0 && num <= quantity_stations - 1
        if num_begin.nil?
          i = true
        elsif num == num_begin
          puts "Начальная станция не должна быть равна конечной"
        else
          i = true
        end
      else
        puts "#{our_object} с таким номером нет в списке"
      end
    end
    num
  end

  def get_menu_train
    puts "--------------------Меню поезда----------------------------"
    puts "Если вы хотите создать поезд нажмите        - 1"
    puts "Если вы хотите добавить вагон к поезду      - 2"
    puts "Если вы хотите отцепить вагон от поезда     - 3"
    puts "Если вы подвинуть поезд по маршруту нажмите - 4"
    puts "Для выхода из меню, нажмите                 - 0"
    puts "============================================================"
    gets.chomp.to_i
  end
end