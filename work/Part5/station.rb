class Station

  attr_reader :tarins_on_station
  attr_reader :station
  #attr_reader :all_stations

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
