class PassengerTrain < Train
  def initialize(number)
    super(number, :passenger)
    register_instance
  end
end
