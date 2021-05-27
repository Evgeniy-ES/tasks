class Wagon
  include Menu
  include ValidateDate
  attr_reader :type, :name, :size
  attr_accessor :used_size
  PASSEGER = :passenger
  CARGO = :cargo

  def validate!
    validate0!
    return if @type != PASSEGER
    msg = 'Количество мест в пассажирском вагоне должно быть целым числом'
    raise msg unless @size.is_a? Integer
  end

  def validate0!
    msg = 'Вагон не создан. Тип вагона должен быть либо PASSEGER либо CARGO'
    raise msg unless @type == PASSEGER || @type == CARGO
    msg = 'Вагон не создан. Название изготовителя не может быть пустым'
    raise msg if @name.nil? || @name == ''
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
    msg = { PASSEGER: 'Мест', CARGO: 'Объем' }
    msg[@type]
  end

  def occupation_volume(volume = 1)
    return puts 'Вагон полон!' if size == used_size
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
