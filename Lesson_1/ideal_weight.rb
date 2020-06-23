print "Please, enter your name: "
person_name = gets.chomp.capitalize
print "Please, enter your height: "
person_height = gets.chomp.to_f
ideal_weight = (person_height - 110) * 1.15
if ideal_weight > 0
  puts "#{person_name}, your ideal wight is #{ideal_weight}"
else
  puts "You have an ideal weight already!"
end