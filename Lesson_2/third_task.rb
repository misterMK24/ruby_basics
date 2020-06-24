arr = []

loop do
  arr << 0 if arr.last == nil
  case arr.last
  when 0
    arr << 1
  else
    arr << arr.last + arr[-2]
  end
  break if arr.last == 89
end

puts arr
