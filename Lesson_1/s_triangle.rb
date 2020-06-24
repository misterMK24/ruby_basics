print "Please, enter triangle base (a): "
triangle_base = gets.chomp.to_f
print "Please, enter triangle height (h): "
triangle_height = gets.chomp.to_f
triangle_s = triangle_base * triangle_height * 0.5
puts "S = #{triangle_s}"
