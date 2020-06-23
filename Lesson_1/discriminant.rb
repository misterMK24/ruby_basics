a, b, c = 0
"a".upto("c") do |coef|
  print("Пожалуйста, введите коэффициент #{coef}: ")
  case coef
    when "a"
      a = gets.chomp.to_f
    when "b"
      b = gets.chomp.to_f
    when "c"
      c = gets.chomp.to_f
  end
end
d = (b ** 2) - (4 * a * c)
a_2 = a * 2
d_sqrt = Math.sqrt(d) if d >= 0
if d > 0
  x1 = (-b + d_sqrt) / a_2
  x2 = (-b - d_sqrt) / a_2
  puts "d = #{d}, x1 = #{x1}, x2 = #{x2}"
elsif d == 0
  x1 = (-b + d_sqrt) / a_2
  puts "d = #{d}, x1 = #{x1}"
else 
  puts "Корней нет!"
end