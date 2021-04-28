class Wagon
  include Menu
  attr_reader :type, :name

  def initialize(name, type)
    @type = type
    @name = name
  end
end
