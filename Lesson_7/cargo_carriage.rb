require_relative "carriage"


class CargoCarriage < Carriage
  attr_reader :occupied_volume

  def initialize(type = "cargo", total_volume)
    @total_volume = total_volume
    @occupied_volume = 0
    super
  end

  def occupy_volume(value)
    check_volume!(value)
    @occupied_volume += value
  end

  def available_volume
    @total_volume - @occupied_volume
  end

  private

  attr_writer :occupied_volume

  def check_volume!(value)
    raise "You don't have enough volume" if available_volume == 0 || (value + @occupied_volume) > @total_volume
  end
end
