require_relative "carriage"


class PassengerCarriage < Carriage

  def initialize(type = "passenger", total_measure)
    super
  end

  def decrease_availability(value = 1)
    check_seat_availability!
    super
  end

  private

  def check_seat_availability!
    raise "You don't have a free seat!" if available_measure == 0
  end
end
