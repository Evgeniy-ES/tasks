class CargoWagon < Wagon
  def initialize(name)
    @type = :cargo
    super(name, :cargo)
  end
end
