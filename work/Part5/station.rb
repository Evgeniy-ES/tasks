class Station

  attr_reader :tarins_on_station
  attr_reader :name

  def initialize(station)
    @name = station
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

  def trains_on_station
    count_cargo = 0
    count_passenger = 0
    @tarins_on_station.each do |train|
      count_cargo += 1 if train.type == :cargo
      count_passenger += 1 if train.type == :passenger
    end
    puts "На станции #{count_passenger} пассажиирских поездов " if count_passenger > 0
    puts "На станции #{count_cargo} грузовых поездов" if count_cargo > 0
  end
end
