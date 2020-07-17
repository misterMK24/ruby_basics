require_relative 'train'
require_relative 'route'
require_relative 'station'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'carriage'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'

class Main
  def menu
    loop do
      puts 'Пожалуйста, выберите необходимое меню:'
      puts MAIN_MENU
      choice = gets.chomp
      case choice
      when '1' then station_interface
      when '2' then train_interface
      when '3' then route_interface
      when '0' then exit
      else puts 'Вы ввели некорректно данные, повторите ввод!'
      end
    end
  end

  # заносим все функции, кроме menu, в private.
  # Класс не является родительским и никто не должен иметь открытый доступ к данный методам и переменным.

  private

  MAIN_MENU = [
    '1. Станции',
    '2. Поезда',
    '3. Маршруты',
    '0. Выйти из программы'
  ].freeze
  STATION_MENU = [
    'Выберите необходимое действие:',
    '1. Создать станцию',
    '2. Просмотреть список всех станций',
    '3. Просмотреть список поездов на станции',
    '9. Главное меню',
    '0. Выйти из программы'
  ].freeze
  TRAIN_MENU =
    {
      main_menu: [
        'Выберите необходимое действие:',
        '1. Создать поезд',
        '2. Выбрать текущий поезд и изменить данные',
        '9. Главное меню',
        '0. Выйти из программы'
      ],
      train_type_menu: [
        'Выберите тип поезда: ',
        '1. Пассажирский',
        '2. Грузовой',
        '3. Предыдущее меню'
      ],
      sub_train_menu: [
        'Выберите необходимое действие: ',
        '1. Назначить маршрут поезду',
        '2. Добавить вагон',
        '3. Убрать вагон',
        '4. Вывести список вагонов',
        '5. Изменить параметр вагона',
        '6. Переместить вперед по маршруту',
        '7. Переместить назад по маршруту',
        '8. Выбрать новый поезд',
        '9. Возврат в предыдущее меню',
        '10. Главное меню',
        '0. Выйти из программы'
      ],
      passenger_carriage_menu: [
        '1. Занять место',
        '2. Предыдущее меню'
      ],
      cargo_carriage_menu: [
        '1. Занять объем',
        '2. Предыдущее меню'
      ]
    }.freeze
  ROUTE_MENU =
    {
      main_menu: [
        'Выберите необходимое действие:',
        '1. Создать маршрут',
        '2. Редактировать маршрут',
        '9. Главное меню меню',
        '0. Выйти из программы'
      ],
      sub_route_menu: [
        'Выберите необходимое действие: ',
        '1. Добавить станцию',
        '2. Убрать станцию',
        '3. Предыдущее меню'
      ]
    }.freeze

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def choose_route
    puts 'Выберите маршрут из списка:'
    @routes.each.with_index(1) { |route, index| puts "#{index}: #{route.stations}" }
    route_position = gets.chomp.to_i - 1
    if @routes[route_position].nil?
      puts 'Вы выбрали несуществующий маршрут'
      return false
    end
    @routes[route_position]
  end

  def choose_station
    puts 'Выберите станцию из списка:'
    @stations.each.with_index(1) { |station, index| puts "#{index}: #{station.name}" }
    station_position = gets.chomp.to_i - 1
    if @stations[station_position].nil?
      puts 'Вы выбрали несуществующую станцию'
      return false
    end
    @stations[station_position]
  end

  def choose_train
    puts 'Выберите поезд из списка:'
    @trains.each.with_index(1) { |train, index| puts "#{index}: #{train.number}" }
    train_position = gets.chomp.to_i - 1
    if @trains[train_position].nil?
      puts 'Вы выбрали несуществующий поезд'
      return false
    end
    @trains[train_position]
  end

  def choose_carriage(current_train)
    puts 'Выберите вагон из списка: '
    current_train.each_carriage { |carriage, index| puts "#{index}: #{carriage}" }
    carriage_position = gets.chomp.to_i - 1
    if current_train.carriages[carriage_position].nil?
      puts 'Вы выбрали несуществующий вагон'
      return false
    end
    current_train.carriages[carriage_position]
  end

  def routes_are_empty?
    if @routes.empty?
      puts 'Нет созданных маршрутов'
      true
    else
      false
    end
  end

  def trains_are_empty?
    if @trains.empty?
      puts 'Нет созданных поездов'
      true
    else
      false
    end
  end

  def stations_are_empty?
    if @stations.empty?
      puts 'Нет созданных станций'
      true
    else
      false
    end
  end

  def route_creation
    if @stations.empty? || @stations.size == 1
      puts 'У Вас нет созданных станций или их меньше двух!'
    else
      @routes << Route.new(choose_station, choose_station)
    end
  end

  def route_interface
    loop do
      puts ROUTE_MENU[:main_menu]
      case gets.chomp
      when '1' then route_creation
      when '2'
        next if routes_are_empty?

        current_route = choose_route
        next unless current_route

        sub_route_interface(current_route)
      when '9' then menu
      when '0' then exit
      end
    end
  end

  def add_station_on_route(current_route)
    current_station = choose_station
    return unless current_station

    current_route.add_station(current_station)
  end

  def delete_station_on_route(current_route)
    current_route.each_station { |station, index| puts "#{index}: #{station.name}" }
    current_station = current_route.stations[gets.chomp.to_i - 1]
    return unless current_route.stations.include? current_station

    current_route.delete_station(current_station)
  end

  def sub_route_interface(current_route)
    loop do
      puts ROUTE_MENU[:sub_route_menu]
      case gets.chomp
      when '1' then add_station_on_route(current_route)
      when '2' then delete_station_on_route(current_route)
      when '3' then route_interface
      end
    end
  end

  def train_creation
    puts TRAIN_MENU[:train_type_menu]
    train_type = gets.chomp
    train_interface if train_type == '3'
    attempt = 3
    begin
      print 'Введите номер поезда: '
      @trains << PassengerTrain.new(gets.chomp) if train_type == '1'
      @trains << CargoTrain.new(gets.chomp) if train_type == '2'
      puts 'Поезд успешно создан!'
    rescue RuntimeError
      attempt -= 1
      puts "Вы ввели некорректный формат номера поезда, повторите попытку. Осталось попыток: #{attempt}"
      retry if attempt.positive?
    end
  end

  def train_interface
    loop do
      puts TRAIN_MENU[:main_menu]
      choice = gets.chomp
      case choice
      when '1' then train_creation
      when '2'
        next if trains_are_empty?

        current_train = choose_train
        next unless current_train

        sub_train_interface(current_train)
      when '9' then menu
      when '0' then exit
      end
    end
  end

  def sub_train_interface(current_train)
    loop do
      puts TRAIN_MENU[:sub_train_menu]
      case gets.chomp
      when '1'
        current_route = choose_route
        next unless current_route

        current_train.add_route(current_route)
        current_route.show_stations
      when '2' then add_carriage_interface(current_train)
      when '3' then current_train.delete_carriage
      when '4' then each_carriage_interface(current_train)
      when '5' then edit_carriage_interface(current_train)
      when '6' then current_train.go_forward
      when '7' then current_train.go_back
      when '8' then current_train = choose_train
      when '9' then train_interface
      when '10' then menu
      when '0' then exit
      end
    end
  end

  def edit_passenger_carriage(current_carriage, current_train)
    puts TRAIN_MENU[:passenger_carriage_menu]
    case gets.chomp
    when '1' then current_carriage.decrease_availability
    when '2' then sub_train_interface(current_train)
    end
  end

  def edit_cargo_carriage(current_carriage, current_train)
    puts TRAIN_MENU[:cargo_carriage_menu]
    case gets.chomp
    when '1'
      print "Введите объем (максимум - #{current_carriage.available_measure}): "
      current_carriage.decrease_availability(gets.chomp.to_i)
    when '2' then sub_train_interface(current_train)
    end
  end

  def edit_carriage_interface(current_train)
    current_carriage = choose_carriage(current_train)
    edit_passenger_carriage(current_carriage, current_train) if current_carriage.instance_of? PassengerCarriage
    edit_cargo_carriage(current_carriage, current_train) if current_carriage.instance_of? CargoCarriage
  end

  def each_carriage_interface(current_train)
    current_train.each_carriage do |carriage, index|
      puts "Номер вагона: #{index}, Тип: #{carriage.type}, " \
          "Свободное пространство: #{carriage.available_measure}, Занято: #{carriage.occupied_measure}"
    end
  end

  def add_carriage_interface(current_train)
    print 'Введите вместительность вагона: '
    current_train.add_carriage(PassengerCarriage.new(gets.chomp.to_i)) if current_train.is_a? PassengerTrain
    current_train.add_carriage(CargoCarriage.new(gets.chomp.to_i)) if current_train.is_a? CargoTrain
    puts 'Вагон успешно добавлен!'
  end

  def station_creation
    print 'Введите наименование станции: '
    station_name = gets.chomp
    if @stations.any? { |station| station.name == station_name }
      puts 'Станция уже существует'
    else
      @stations << Station.new(station_name)
      puts 'Станция успешно создана!'
    end
  end

  def print_station
    return if stations_are_empty?

    @stations.each.with_index(1) { |station, index| puts "#{index}: #{station.name}" }
  end

  def print_trains
    return if stations_are_empty?

    choose_station.each_train do |train|
      puts "Номер поезда: #{train.number}. Тип: #{train.type}. Количество вагонов: #{train.carriages.size}"
    end
  end

  def station_interface
    loop do
      puts STATION_MENU
      case gets.chomp
      when '1' then station_creation
      when '2' then print_station
      when '3' then print_trains
      when '9' then menu
      when '0' then exit
      end
    end
  end
end

main_instance = Main.new
main_instance.menu
