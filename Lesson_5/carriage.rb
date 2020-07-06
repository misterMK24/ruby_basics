require_relative "manufacturer_module"


class Carriage
  include Manufacturer

  def initialize(type = nil)
    @type = type
  end
end
