a, b, c = 0
"a".upto("c") do |side|
  print("Пожалуйста, введите сторону #{side}: ")
  case side
    when "a"
      a = gets.chomp.to_f
    when "b"
      b = gets.chomp.to_f
    when "c"
      c = gets.chomp.to_f
  end
end
pythagorean_statement = false
if (a > b) && (a > c) 
  pythagorean_statement = (a ** 2) == (b ** 2 + c ** 2)
  case true
    when pythagorean_statement && (b == c)
      puts "Треугольник прямоугольный и равнобедренный!"
    when pythagorean_statement && (b != c)
      puts "Треугольник прямоугольный!"
    when b == c
      puts "Треугольник равнобедренный!"            
    else
      puts "Треугольник не является ни равнобедренным, ни прямоугольным, ни равносторонним!"
  end
elsif (b > a) && (b > c)
  pythagorean_statement = (b ** 2) == (a ** 2 + c ** 2)
  case true
    when pythagorean_statement && (a == c)
      puts "Треугольник прямоугольный и равнобедренный!"
    when pythagorean_statement && (a != c)
      puts "Треугольник прямоугольный!"
    when a == c
      puts "Треугольник равнобедренный!"            
    else
      puts "Треугольник не является ни равнобедренным, ни прямоугольным, ни равносторонним!"
  end
elsif (c > a) && (c > b)
  pythagorean_statement = (c ** 2) == (a ** 2 + b ** 2)
  case true
    when pythagorean_statement && (a == b)
      puts "Треугольник прямоугольный и равнобедренный!"
    when pythagorean_statement && (a != b)
      puts "Треугольник прямоугольный!"  
    when a == b
      puts "Треугольник равнобедренный!"            
    else
      puts "Треугольник не является ни равнобедренным, ни прямоугольным, ни равносторонним!"
  end
else
  case true
    when ((a == b) || (a == c)) || (b == c)
      puts "Треугольник равнобедренный!"
    else
      puts "Треугольник не является ни равнобедренным, ни прямоугольным, ни равносторонним!"
  end
end