class Wagon
  include Menu
  include ValidateDate
  attr_reader :type, :name

  def validate!
    raise "Вагон не создан. Тип вагона должен быть либо  :passenger либо :cargo" if @type == :passenger || @type == :cargo
    raise "Вагон не создан. Название изготовителя не может быть пустым"  if @name.nil? || @name == ""      
  end

  def initialize(name, type)
    @type = type
    @name = name
    validate
  end
end
