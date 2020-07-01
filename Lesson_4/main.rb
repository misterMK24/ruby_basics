require_relative "train"
require_relative "route"
require_relative "station"
require_relative "cargo_train"
require_relative "passenger_train"
require_relative "carriage"
require_relative "cargo_carriage"
require_relative "passenger_carriage"


class Main
  def menu
    loop do
      puts "Пожалуйста, выберите необходимое меню:"
      puts MAIN_MENU
      choice = gets.chomp
      case choice
      when "1" then station_interface
      when "2" then train_interface
      when "3" then route_interface
      when "0" then exit
      else puts "Вы ввели некорректно данные, повторите ввод!"
      end
    end
  end

=begin
заносим все функции, кроме menu, в private.
Класс не является родительским и никто не должен иметь открытый доступ к данный методам и переменным.
=end

private

  MAIN_MENU = [
    "1. Станции",
    "2. Поезда",
    "3. Маршруты",
    "0. Выйти из программы"
  ]
  STATION_MENU = [
    "1. Создать станцию",
    "2. Просмотреть список всех станций",
    "3. Просмотреть список поездов на станции",
    "9. Главное меню",
    "0. Выйти из программы"
  ]
  TRAIN_MENU =
  {
    main_menu: [
      "1. Создать поезд",
      "2. Выбрать текущий поезд и изменить данные",
      "9. Главное меню",
      "0. Выйти из программы"
    ],
    train_type_menu: [
      "1. Пассажирский",
      "2. Грузовой",
      "3. Предыдущее меню"
    ],
    sub_train_menu: [
    "1. Назначить маршрут поезду",
    "2. Добавить вагон",
    "3. Убрать вагон",
    "4. Переместить вперед по маршруту",
    "5. Переместить назад по маршруту",
    "6. Выбрать новый поезд",
    "7. Возврат в предыдущее меню",
    "9. Главное меню",
    "0. Выйти из программы"
    ]
  }
  ROUTE_MENU =
  {
    main_menu: [
    "1. Создать маршрут",
    "2. Редактировать маршрут",
    "9. Главное меню меню",
    "0. Выйти из программы"
    ],
    sub_route_menu: [
      "1. Добавить станцию",
      "2. Убрать станцию",
      "3. Предыдущее меню"
    ]
  }

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def choose_route
    puts "Выберите маршрут из списка:"
    @routes.each.with_index(1) { |route, index| puts "#{index}: #{route.stations}" }
    route_position = gets.chomp.to_i - 1
    if @routes[route_position].nil?
      puts "Вы выбрали несуществующий маршрут"
      return false
    end
    @routes[route_position]
  end

  def choose_station
    puts "Выберите станцию из списка:"
    @stations.each.with_index(1) { |station, index| puts "#{index}: #{station.name}" }
    station_position = gets.chomp.to_i - 1
    if @stations[station_position].nil?
      puts "Вы выбрали несуществующую станцию"
      return false
    end
    @stations[station_position]
  end

  def choose_train
    puts "Выберите поезд из списка:"
    @trains.each.with_index(1) { |train, index| puts "#{index}: #{train.number}" }
    train_position = gets.chomp.to_i - 1
    if @trains[train_position].nil?
      puts "Вы выбрали несуществующий поезд"
      return false
    end
    @trains[train_position]
  end

  def routes_are_empty?
    if @routes.empty?
      puts "Нет созданных маршрутов"
      return true
    else
      return false
    end
  end

  def trains_are_empty?
    if @trains.empty?
      puts "Нет созданных поездов"
      return true
    else
      false
    end
  end

  def stations_are_empty?
    if @stations.empty?
      puts "Нет созданных станций"
      return true
    else
      false
    end
  end

  def route_interface
    loop do
      puts "Выберите необходимое действие:"
      puts ROUTE_MENU[:main_menu]
      choice = gets.chomp
      case choice
      when "1"
        if @stations.empty? || @stations.size == 1
          puts "У Вас нет созданных станций или их меньше двух!"
          next
        else
          puts "Выберите первую и последнюю станции: "
          first_station = choose_station
          last_station = choose_station
          @routes << Route.new(first_station, last_station)
          puts "Маршрут создан успешно"
        end
      when "2"
        next if routes_are_empty?
        current_route = choose_route
        next unless current_route
        sub_route_interface(current_route)
      when "9" then menu
      when "0" then exit
      else puts "Вы ввели некорректно данные, повторите ввод!"
      end
    end
  end

  def sub_route_interface(current_route)
    loop do
      puts "Выберите необходимое действие: "
      puts ROUTE_MENU[:sub_route_menu]
      choice = gets.chomp
      case choice
      when "1"
        current_station = choose_station
        next unless current_station
        current_route.add_station(current_station)
      when "2"
        puts "Выберите станцию: "
        current_route.stations.each.with_index(1) { |station, index| puts "#{index}: #{station.name}" }
        current_station = current_route.stations[gets.chomp.to_i - 1]
        next unless current_route.stations.include? (current_station)
        current_route.delete_station(current_station)
      when "3" then route_interface
      else puts "Вы ввели некорректно данные, повторите ввод!"
      end
    end
  end

  def train_interface
    loop do
      puts "Выберите необходимое действие:"
      puts TRAIN_MENU[:main_menu]
      choice = gets.chomp
      case choice
      when "1"
        puts "Выберите тип поезда: "
        puts TRAIN_MENU[:train_type_menu]
        train_type = gets.chomp
        print "Введите номер поезда: " unless train_type == "3"
        @trains << PassengerTrain.new(gets.chomp) if train_type == "1"
        @trains << CargoTrain.new(gets.chomp) if train_type == "2"
        train_interface if train_type == "3"
      when "2"
        next if trains_are_empty?
        current_train = choose_train
        next unless current_train
        sub_train_interface(current_train)
      when "9" then menu
      when "0" then exit
      else puts "Вы ввели некорректно данные, повторите ввод!"
      end
    end
  end

  def sub_train_interface(current_train)
    loop do
      puts "Выберите необходимое действие: "
      puts TRAIN_MENU[:sub_train_menu]
      choice = gets.chomp
      case choice
      when "1"
        current_route = choose_route
        next unless current_route
        current_train.add_route(current_route)
        current_route.show_stations
      when "2"
        current_train.add_carriage(PassengerCarriage.new) if current_train.instance_of? (PassengerTrain)
        current_train.add_carriage(CargoCarriage.new) if current_train.instance_of? (CargoTrain)
        puts "Вагон успешно добавлен!"
      when "3"
        current_train.delete_carriage
        puts "Вагон успешно удален!"
      when "4" then current_train.go_forward
      when "5" then current_train.go_back
      when "6" then current_train = choose_train
      when "7" then train_interface
      when "9" then menu
      when "0" then exit
      else puts "Вы ввели некорректно данные, повторите ввод!"
      end
    end
  end

  def station_interface
    loop do
      puts "Выберите необходимое действие:"
      puts STATION_MENU
      choice = gets.chomp
      case choice
      when "1"
        print "Введите наименование станции: "
        station_name = gets.chomp
        if @stations.any? { |station| station.name == station_name }
          puts "Станция уже существует"
          next
        else
          @stations << Station.new(station_name)
        end
      when "2"
        next if stations_are_empty?
        @stations.each.with_index(1) { |station, index| puts "#{index}: #{station.name}" }
      when "3"
        next if stations_are_empty?
        choose_station.trains.each.with_index(1) {
         |train, index| puts "#{index}: #{train.number}" }
      when "9" then menu
      when "0" then exit
      else puts "Вы ввели некорректно данные, повторите ввод!"
      end
    end
  end
end


main_instance = Main.new
main_instance.menu
