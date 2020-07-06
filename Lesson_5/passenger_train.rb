class PassengerTrain < Train
  def add_carriage(carriage)
    return nil unless is_passenger?(carriage)
    super
  end

  private

  self.declare_instance_counter

  # внутренний метод, необходимый для работы в самом классе.
  def is_passenger?(carriage)
    carriage.instance_of?(PassengerCarriage)
  end
end
