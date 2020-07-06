require_relative "train"
# require_relative "manufacturer_module"


class CargoTrain < Train
  def add_carriage(carriage)
    return nil unless is_cargo?(carriage)
    super
  end

  private

  self.declare_instance_counter

  # внутренний метод, необходимый для работы в самом классе.
  def is_cargo?(carriage)
    carriage.instance_of?(CargoCarriage)
  end
end
