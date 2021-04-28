module Menu
  def get_menu_main
    puts "---------------------Меню-----------------------"
    msg = ["выйти из меню", "работать со станциями", "работать с  поездами", "работать с  маршрутами"]
    msg.each_index { |x| you_want(msg[x], x)}
    puts "============================================================"
    gets.chomp.to_i
  end

  def get_menu_station
    puts "--------------------Меню станции----------------------------"
    msg = ["выйти из меню", "создать станцию", "посмотреть все станции", "посмотреть все поезда на станции", "посмотреть поезд определенного типа"]
    msg.each_index { |x| you_want(msg[x], x)}
    puts "============================================================"
    gets.chomp.to_i
  end

  def get_menu_train
    puts "--------------------Меню поезда----------------------------"
    msg = ["выйти из меню", "создать поезд", "добавить вагон к поезду", "отцепить вагон от поезда", "подвинуть поезд по маршруту", "найти поезд", "добавить поезду маршрут"]
    msg.each_index { |x| you_want(msg[x], x)}
    puts "============================================================"
    gets.chomp.to_i
  end

  def get_menu_route
    puts "--------------------Меню маршрута----------------------------"
    msg = ["выйти из меню", "создать маршрут", "добавить станцию в маршрут"]
    msg.each_index { |x| you_want(msg[x], x)}
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
