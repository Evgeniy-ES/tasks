class CargoWagon < Wagon
  def initialize(name, size)
    @type = :cargo
    super(name, size, :cargo)
  end
end
