class PassengerTrain < Train

  attr_reader :type

  def initialize(number, company)
    super(number, company)
    @type = :passenger
    @@trains << self
  end
end
