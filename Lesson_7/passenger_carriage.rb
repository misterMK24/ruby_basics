require_relative "carriage"


class PassengerCarriage < Carriage
  attr_reader :occupied_seats

  def initialize(type = "passenger", total_seats)
    @total_seats = total_seats
    @occupied_seats = 0
    super
  end

  def take_seat
    check_seat_availability!
    @occupied_seats += 1
  end

  def available_seats
    @total_seats - @occupied_seats
  end

  private

  attr_writer :occupied_seats

  def check_seat_availability!
    raise "You don't have a free seat!" if available_seats == 0
  end
end
