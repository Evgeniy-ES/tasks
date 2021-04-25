class CargoTrain < Train

  attr_reader :type

  def initialize(number, company)
    super(number, company)
    @type = :cargo
    @@trains << self
  end
end
