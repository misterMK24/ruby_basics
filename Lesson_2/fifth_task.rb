months_hash = {
  "1" => 31,
  "2" => 28,
  "3" => 31,
  "4" => 30,
  "5" => 31,
  "6" => 30,
  "7" => 31,
  "8" => 31,
  "9" => 30,
  "10" => 31,
  "11" => 30,
  "12" => 31
}

print "Enter date: "
index_number = gets.chomp.to_i
print "Enter month: "
month = gets.chomp
print "Enter year: "
year = gets.chomp.to_i
leap_year_statement = false

if (year % 4) == 0
  if (year % 100 == 0) && (year % 400 == 0)
    leap_year_statement = true
  elsif (year % 100 == 0)
    leap_year_statement = false
  else
     leap_year_statement = true
  end
end

months_hash["2"] = 29 if leap_year_statement

months_hash.each do |key, value|
  break if key == month
  index_number += value
end
puts index_number
