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
  purchases[product] = {
    price: price,
    amount: amount
  }
end

purchases.each do |key, value|
  price_for_one = value[:price]
  amount_for_one = value[:amount]
  puts "Товар: #{key}, Цена за единицу: #{price_for_one}, Количество: #{amount_for_one}, Итоговая сумма: #{price_for_one * amount_for_one}"
  total_price += price_for_one * amount_for_one
end

puts "Итоговая стоимость всех продуктов составляет: #{total_price}"
