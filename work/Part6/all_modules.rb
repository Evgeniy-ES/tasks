module Menu
  def get_menu_main
    menu_generator("Меню",  ["выйти из меню", "работать со станциями", "работать с поездами", "работать с маршрутами"])
  end

  def get_menu_station
    menu_generator("Меню станции", ["выйти из меню", "создать станцию", "посмотреть все станции", "посмотреть все поезда на станции", "посмотреть поезд определенного типа"])
  end

  def get_menu_train
    menu_generator("Меню поезда",  ["выйти из меню", "создать поезд", "добавить вагон к поезду", "отцепить вагон от поезда", "подвинуть поезд по маршруту", "найти поезд", "добавить поезду маршрут"])
  end

  def get_menu_route
    menu_generator("Меню маршрута", ["выйти из меню", "создать маршрут", "добавить станцию в маршрут"])
  end

  def menu_generator(title, options)
    puts "---------------------#{title}-----------------------"
    options.each_with_index { |msg, index| you_want(msg, index) }
    puts "============================================================"
    gets.chomp.to_i
  end

  def you_want(wish0, push_num)
    puts "Если вы хотите #{wish0} нажмите - #{push_num}"
  end

  def enter_company
    puts "Введите производителя либо 0, если не знаете"
    name = gets.chomp
    if name == 0
      name = "noname"
    end
    name
  end
end


module Company
  def set_name_company(name)
    self.name = name
  end

  def show_name_company
    self.name
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
