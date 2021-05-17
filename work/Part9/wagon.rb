class Wagon
  include Menu
  include ValidateDate
  attr_reader :type, :name, :size
  attr_accessor :used_size

  def validate!
    msg = 'Вагон не создан. Тип вагона должен быть либо :passenger либо :cargo'
    raise msg unless @type == :passenger || @type == :cargo
    msg = 'Вагон не создан. Название изготовителя не может быть пустым'
    raise msg if @name.nil? || @name == ""

    if @type == :passenger
      msg = 'Количество мест в пассажирском вагоне должно быть целым числом'
      raise msg unless @size.is_a? Integer
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
    size - used_size
  end

  def wagon_msg
   msg = { :passenger => 'Мест', :cargo => 'Объем' }
   msg[@type]
  end

  def occupation_volume(volume = 1)
    return puts "Вагон полон!" if size == used_size
    return msg_occupation_volume(volume) if size - used_size - volume < 0
    @used_size += volume
    msg = 'Заполнение прошло успешно. Всего'
    puts msg + " #{wagon_msg} #{@size}. Свободно #{free_volume}"
  end

  def msg_occupation_volume(volume)
    msg = 'в вагоне меньше, чем вы хотите ввести! Вы ввели'
    puts " #{wagon_msg} " + msg + " #{volume}, свободно #{free_volume}"
  end
end
