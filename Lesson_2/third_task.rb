arr = [0, 1]
fibonacci_number = 0

loop do
  fibonacci_number = arr.last + arr[-2]
  break if fibonacci_number > 100
  arr << fibonacci_number
end

puts arr
