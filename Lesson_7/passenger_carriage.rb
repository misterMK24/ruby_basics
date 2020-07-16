require_relative 'carriage'

class PassengerCarriage < Carriage
  def initialize(total_measure, type = 'passenger')
    super
  end

  def decrease_availability(value = 1)
    check_seat_availability!
    super
  end

  private

  def check_seat_availability!
    raise "You don't have a free seat!" if available_measure.zero?
  end
end
