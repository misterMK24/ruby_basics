require_relative 'train'

class PassengerTrain < Train
  @trains = {}

  def initialize(number)
    @type = 'passenger'
    super
  end

  def add_carriage(carriage)
    return nil unless passenger?(carriage)

    super
  end

  private

  # внутренний метод, необходимый для работы в самом классе.
  def passenger?(carriage)
    carriage.instance_of?(PassengerCarriage)
  end
end
