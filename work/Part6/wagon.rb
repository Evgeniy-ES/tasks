class Wagon
  require_relative 'company'

  include Company
  attr_reader :type
  attr_reader :manufacturer

end
