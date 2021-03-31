print "Enter day = "
day = gets.chomp.to_i
print "Enter month = "
month = gets.chomp.to_i
print "Enter year = "
year = gets.chomp.to_i

if day < 1 || month < 1 || year < 1 || day > 31 || month > 12
  puts "The date is incorrect"
  return
end

months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
months[1] = 29 if (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
number = months.take(month - 1).sum + day

puts number
