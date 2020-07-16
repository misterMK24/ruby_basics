require_relative 'train'

class PassengerTrain < Train
  def initialize(number)
    @type = 'passenger'
    super
  end

  def add_carriage(carriage)
    return nil unless is_passenger?(carriage)

    super
  end

  private

  # внутренний метод, необходимый для работы в самом классе.
  def is_passenger?(carriage)
    carriage.instance_of?(PassengerCarriage)
  end
end
