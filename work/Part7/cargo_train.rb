class CargoTrain < Train
  def initialize(number)
    super(number, :cargo)
    self.register_instance
  end
end
