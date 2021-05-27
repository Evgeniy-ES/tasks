module Menu
  def menu_main
    menu_generator('Меню',
                   ['выйти из меню',
                    'работать со станциями',
                    'работать с поездами',
                    'работать с маршрутами'])
  end

  def menu_station
    menu_generator('Меню станции',
                   ['выйти из меню',
                    'создать станцию',
                    'посмотреть все станции',
                    'посмотреть все поезда на станции',
                    'посмотреть поезд определенного типа',
                    'Информация о станциях'])
  end

  def menu_train
    menu_generator('Меню поезда',
                   ['выйти из меню',
                    'создать поезд',
                    'добавить вагон к поезду',
                    'отцепить вагон от поезда',
                    'подвинуть поезд по маршруту',
                    'найти поезд',
                    'добавить поезду маршрут',
                    'занять место/объем в вагоне поезда'])
  end

  def menu_route
    menu_generator('Меню маршрута',
                   ['выйти из меню',
                    'создать маршрут',
                    'добавить станцию в маршрут'])
  end

  def menu_generator(title, options)
    puts "---------------------#{title}-----------------------"
    options.each_with_index { |msg, index| you_want(msg, index) }
    gets.chomp.to_i
  end

  def you_want(wish0, push_num)
    puts "Если вы хотите #{wish0} нажмите - #{push_num}"
  end

  def enter_company
    puts 'Введите наименование производителя'
    name = gets.chomp
    name = 'noname' if name.nil?
    name
  end
end

module Company
  def name_company(name)
    self.name = name
  end

  def show_name_company
    name
  end

  protected

  attr_accessor :name
end

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def self.extended(target)
      target.instance_variable_set(:@instances, 0)
      class << target; attr_accessor :instances end
    end

    def inherited(subclass)
      subclass.instance_variable_set(:@instances, 0)
      class << subclass; attr_accessor :instances end
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.instances += 1
    end
  end
end

module ValidateDate
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
  end

  module InstanceMethods
    def validate
      validate!
    rescue RuntimeError => event
      puts event.message
    end

    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end
  end
end