class Station
  require_relative 'all_modules'
  require_relative 'train'
  include InstanceCounter
  include ValidateDate

  attr_reader :name, :trains_on_station
  @@stations = []

  def self.all
    @@stations.each_index { |x| puts " Индекс #{x} станция #{@@stations[x]}, имя станции  #{@@stations[x].name}"}
  end

  def self.get_station(index)
    @@stations[index]
  end

  def validate!
    raise "В названии станции должно содержаться как минимум 2 буквы" if @name !~ /[a-zа-я]{2}/
  end

  def initialize(station)
    @name = station
    validate
    if self.valid? == true
      @@stations << self
      @trains_on_station = []
      self.register_instance
    end
  end

  def arrive(train)       # прибытие поезда
    @trains_on_station << train
    puts "Поезд с номером #{train.number} прибыл на станцию #{self.name}"
  end

  def departure(train)       # отбытие поезда
    if @trains_on_station.include?(train)
      @trains_on_station.delete(train)
      puts "Поезд с номером #{train.number} отбыл со станции #{self.name}"
    else
      puts "Поезда с таким номером нет на станции"
    end
  end

  def trains_on_station_by_type(type)      # поезда определенного типа
    trains_type = @trains_on_station.filter { |train| train.type == type }
    puts trains_type
  end

  def train_on_station(&block)
    @trains_on_station.each { |train| block.call(train) }
  end

  def self.info_about_stations
      @@stations.each_index do |index_station|
        puts " Имя станции  #{@@stations[index_station].name}"

        if @@stations[index_station].trains_on_station.size > 0
          puts "На станции:"
          @@stations[index_station].trains_on_station.each do |train|            
            puts " - Поезд тип #{train.type}, номер #{train.number}, количество вагонов #{train.wagons.size}"
            if train.wagons.size > 0
              puts "Вагоны поезда:"
              train.all_wagons_train { |x| puts "Вагон номер #{x} вагон типа #{train.wagons[x].type}, всего #{train.wagons[x].wagon_msg} #{train.wagons[x].size}, свободно #{train.wagons[x].free_volume}"}
              puts "---------------------------"
            end
          end
        else
          puts "На станции нет поездов."
        end
      end
  end
end
