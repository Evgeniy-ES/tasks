class CargoTrain < Train
  def initialize(number)
    super(number, :cargo)
    register_instance
  end
end
