print("Пожалуйста, введите сторону a: ")
a = gets.chomp.to_f**2
print("Пожалуйста, введите сторону b: ")
b = gets.chomp.to_f**2
print("Пожалуйста, введите сторону c: ")
c = gets.chomp.to_f**2
arr = [a, b, c]
max = arr.max
min = arr.min
two_sides_statement = (b == c) || (a == c) || (a == b)

case max
when min
  puts "Треугольник равносторонний и равнобедренный!"
when a
  pythagorean_statement = (a) == (b + c)
  puts "Треугольник прямоугольный и равнобедренный!" if (pythagorean_statement && two_sides_statement)
  puts "Треугольник прямоугольный!" if (pythagorean_statement && not(two_sides_statement))
  puts "Треугольник равнобедренный" if (not(pythagorean_statement) && two_sides_statement)
  puts "Треугольник не является ни равнобедренным, ни прямоугольным, ни равносторонним!" unless (pythagorean_statement || two_sides_statement )
when b
  pythagorean_statement = (b) == (a + c)
  puts "Треугольник прямоугольный и равнобедренный!" if (pythagorean_statement && two_sides_statement)
  puts "Треугольник прямоугольный!" if (pythagorean_statement && not(two_sides_statement))
  puts "Треугольник равнобедренный" if (not(pythagorean_statement) && two_sides_statement)
  puts "Треугольник не является ни равнобедренным, ни прямоугольным, ни равносторонним!" unless (pythagorean_statement || two_sides_statement )
when c
  pythagorean_statement = (c) == (a + b)
  puts "Треугольник прямоугольный и равнобедренный!" if (pythagorean_statement && two_sides_statement)
  puts "Треугольник прямоугольный!" if (pythagorean_statement && not(two_sides_statement))
  puts "Треугольник равнобедренный" if (not(pythagorean_statement) && two_sides_statement)
  puts "Треугольник не является ни равнобедренным, ни прямоугольным, ни равносторонним!" unless (pythagorean_statement || two_sides_statement)
end
