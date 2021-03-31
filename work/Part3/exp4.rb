# задача решена для строчных букв
letters= ('a'..'z')
vowels_array = %w{ a e i o u y }
vowels_hash = {}
count = 1
letters.each_with_index do |letter, index|
  if vowels_array.include?(letter)
    vowels_hash[letter] = index
  end
end
puts vowels_hash
