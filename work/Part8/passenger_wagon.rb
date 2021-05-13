class PassengerWagon < Wagon

  def initialize(name, size)
    @type = :passenger
    super(name, size, :passenger)
  end
end
