class Carriage
  attr_reader :type

  def initialize(type = nil, some_measure = nil)
    @type = type
  end
end
