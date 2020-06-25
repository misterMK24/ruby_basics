vowels = ["а", "е", "и", "й", "о", "у", "ы", "э", "ю", "я"]
vowels_hash = {}
("а".."я").each.with_index(1) do |letter, index|
  vowels_hash[letter] = index if vowels.include? letter
end

puts vowels_hash
