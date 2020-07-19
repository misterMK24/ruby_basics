class CargoTrain < Train
  @trains = {}

  def initialize(number)
    @type = 'cargo'
    super
  end

  def add_carriage(carriage)
    return nil unless cargo?(carriage)

    super
  end

  private

  # внутренний метод, необходимый для работы в самом классе.
  def cargo?(carriage)
    carriage.instance_of?(CargoCarriage)
  end
end
