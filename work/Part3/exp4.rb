# задача решена для строчных букв
letters= ('a'..'z')
vowels_array = %w{ a e i o u y }
vowels_hash = {}
count = 1
letters.each do |letter|
  if vowels_array.include?(letter)
    vowels_hash[letter] = count
  end
  count += 1
end
puts vowels_hash
