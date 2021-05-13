class PassengerWagon < Wagon

  def initialize(name, size)
    @type = :passenger
    super(name, size, @type)
  end
end
