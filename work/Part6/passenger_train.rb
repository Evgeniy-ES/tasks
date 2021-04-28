class PassengerTrain < Train
  def initialize(number)
    super(number, :passenger)
    self.register_instance
  end
end
