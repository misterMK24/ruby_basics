print("Пожалуйста, введите коэффициент a: ")
a = gets.chomp.to_f
print("Пожалуйста, введите коэффициент b: ")
b = gets.chomp.to_f
print("Пожалуйста, введите коэффициент c: ")
c = gets.chomp.to_f

d = (b**2) - (4 * a * c)

# а_2 не стал заносить в блок, так как он используется в двух условиях
a_2 = a * 2

if d > 0
  d_sqrt = Math.sqrt(d)
  x1 = (-b + d_sqrt)/a_2
  x2 = (-b - d_sqrt)/a_2
  puts "d = #{d}, x1 = #{x1}, x2 = #{x2}"
elsif d == 0
  x1 = -b/a_2
  puts "x1 = #{x1}"
else
  puts "Корней нет!"
end
