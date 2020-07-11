class CargoTrain < Train
  def initialize(number)
    @type = "cargo"
    super
  end

  def add_carriage(carriage)
    return nil unless is_cargo?(carriage)
    super
  end

  private

  # внутренний метод, необходимый для работы в самом классе.
  def is_cargo?(carriage)
    carriage.instance_of?(CargoCarriage)
  end
end
