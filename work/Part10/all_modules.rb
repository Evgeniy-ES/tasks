module Accessors
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods

    def attr_accessor_with_history(*methods)
      options = methods.last.is_a?(Hash)? methods.pop: {}
      methods.each do |method|
        raise TypeError.new("method name is not symbol") unless method.is_a?(Symbol)
        define_method(method) do
          instance_variable_get("@#{method}") ||
          instance_variable_set("@#{method}", options[:default])
        end

      define_method("#{method}=") do |value|
        instance_variable_set("@#{method}", value)
        var_history_name = "@#{method}_history"
        instance_variable_set(var_history_name, []) unless instance_variable_get(var_history_name)
        @array_history_name = instance_variable_get(var_history_name)
        unless @array_history_name.include?(value)
          @array_history_name << value
          instance_variable_set(var_history_name, @array_history_name)
        end
      end

      history_name = "#{method}_history"
      define_method(history_name) do
        instance_variable_get("@#{history_name}") ||
          instance_variable_set("@#{history_name}", @array_history_name)
      end

      define_method(history_name) do
        instance_variable_get("@#{history_name}") ||
          instance_variable_set("@#{history_name}", options[:default])
      end
    end
  end

    def strong_attr_accessor(name, name_class)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=") do |value|
        raise "Ошибка типов данных. Необходим класс: #{name_class}" if value.class.name.capitalize != name_class.to_s.capitalize
        instance_variable_set(var_name, value)
      end
    end
  end

  module InstanceMethods
  end
end

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(attr, type, *args)
      attr = attr.to_sym
      type = type.to_sym
      var_name = "@data_valid"

      instance_variable_set(var_name, {}) unless instance_variable_get(var_name)
      data_valid = instance_variable_get(var_name)

      class << self ; attr_reader :data_valid end

      data_valid[attr] ||= { type => args }
      data_valid[attr].merge!( type => args )
    end
  end

  module InstanceMethods
    def validate!
      self.class.data_valid.each do |name, data|
        val_name = instance_variable_get("@#{name}")
        if data.key?(:presence)
          raise "Атрибут #{name} не может быть пустым или не определенным!" if val_name.nil? || val_name == 0 || val_name == ''
        end

        if data.key?(:format)
          data[:format].each do |format|
            raise "Атрибут #{name} не соответствует формату!" if val_name !~ format
          end
        end

        if data.key?(:type)
          data[:type].each do |type|
            raise "Атрибут #{name} не соответствует типу #{type}" if val_name.class.name != type.to_s
          end
        end
      end
    end

    def validate
      validate!
    rescue RuntimeError => event
      puts event.message
    end

    def valid?
      validate!
      true
    rescue StandardError
      puts 'Объект не создан'
      false
    end
  end
end




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
