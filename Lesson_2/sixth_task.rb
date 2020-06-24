purchases = {}
total_price = 0

loop do
  print "Введите наименование товара: "
  product = gets.chomp.downcase
  break if product == "стоп"
  print "Введите цену за единицу товара: "
  price = gets.chomp.to_f
  print "Введите количество купленного товара: "
  amount = gets.chomp.to_f
  purchases[product] = {price => amount}
end

purchases.each do |key, value|
  print "Товар: #{key}, "
  value.each do |k, v|
    total_price += k * v
    puts "Цена за единицу: #{k}, Количество: #{v}, Итоговая сумма: #{k * v}"
  end
end

puts "Итоговая стоимость всех продуктов составляет: #{total_price}"
