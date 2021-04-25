class CargoWagon < Wagon

  def initialize(company)
    @type = :cargo
    @manufacturer = name_company(company)
  end
end
