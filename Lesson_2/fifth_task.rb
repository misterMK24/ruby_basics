months_array = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

print "Enter date: "
index_number = gets.chomp.to_i
print "Enter month: "
month = gets.chomp.to_i
print "Enter year: "
year = gets.chomp.to_i
leap_year_statement = false

leap_year_statement = true if ((year % 4) == 0) || ((year % 100 == 0) && (year % 400 == 0))
months_array[1] = 29 if leap_year_statement
index_number += months_array.first(month-1).sum

puts index_number
