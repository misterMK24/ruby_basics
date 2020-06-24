vowels = ["а", "е", "и", "й", "о", "у", "ы", "э", "ю", "я"]
vowels_hash = {}
("а".."я").each_with_index do |letter, index|
  vowels_hash[letter] = index + 1 if vowels.include? letter
end

puts vowels_hash
