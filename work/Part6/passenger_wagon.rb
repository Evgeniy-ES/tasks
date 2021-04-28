class PassengerWagon < Wagon
  def initialize(name)
    @type = :passenger
    super(name, :passenger)
  end
end
