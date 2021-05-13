class CargoWagon < Wagon
  def initialize(name, size)
    @type = :cargo
    super(name, size, @type)
  end
end
