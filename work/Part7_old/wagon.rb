class Wagon
  include Menu
  attr_reader :type, :name

  def validate!
    if @type == :passenger || @type == :cargo
      @type = type
    else
      raise puts "Тип вагона должен быть либо  :passenger либо :cargo"
    end

    if @name.nil? || @name == ""
      raise puts "Название изготовителя не может быть пустым"
    end
  end

  def valid?
    rezult = true
    if @type == :passenger || @type == :cargo || @name.nil?
      rezult = false
    end
    rezult
  end

  def initialize(name, type)
    begin
      @type = type
      @name = name
      validate!
    rescue
      puts "Вагон не создан"
    end
  end
end
