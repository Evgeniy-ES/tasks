class PassengerWagon < Wagon

  def initialize(company)
    @type = :passenger
    @manufacturer = name_company(company)
  end
end
