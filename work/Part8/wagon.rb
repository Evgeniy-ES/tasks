class Wagon
  include Menu
  include ValidateDate
  attr_reader :type, :name, :size
  attr_accessor :used_size

  def validate!
    raise "Вагон не создан. Тип вагона должен быть либо  :passenger либо :cargo" unless @type == :passenger || @type == :cargo
    raise "Вагон не создан. Название изготовителя не может быть пустым"  if @name.nil? || @name == ""

    if @type == :passenger
      raise "Количество мест в пассажирском вагоне должно быть целым числом" unless @size.is_a? Integer
    end
  end

  def initialize(name, size, type)
    @type = type
    @name = name
    @size = size
    validate
    @used_size = 0
  end

  def free_volume
    @size - @used_size
  end

  def wagon_msg
   msg = { :passenger => 'Мест', :cargo => 'Объем' }
   msg[@type]
  end

  def occupation_volume(volume = 1)
    return puts "Вагон полон!" if @size == @used_size
    return puts " #{self.wagon_msg} в вагоне меньше, чем вы хотите ввести! Вы ввели #{volume}, свободно #{self.free_volume}" if @size - @used_size - volume < 0
    @used_size += volume
    puts "Заполнение прошло успешно. Всего #{self.wagon_msg} #{@size}. Свободно #{self.free_volume}"
  end
end
