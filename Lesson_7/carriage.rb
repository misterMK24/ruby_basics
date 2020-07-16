class Carriage
  attr_reader :type, :occupied_measure

  def initialize(total_measure = nil, type = nil)
    @type = type
    @total_measure = total_measure
    @occupied_measure = 0
  end

  def available_measure
    @total_measure - @occupied_measure
  end

  protected

  def decrease_availability(value = nil)
    @occupied_measure += value
  end

  private

  attr_writer :occupied_measure
end
