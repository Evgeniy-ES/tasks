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

months = []
months[1] = 31
months[2] = 28
months[3] = 31
months[4] = 30
months[5] = 31
months[6] = 30
months[7] = 31
months[8] = 31
months[9] = 30
months[10] = 31
months[11] = 30
months[12] = 31

months[2] = 29 if (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)

number = 0 # порядковый номер даты начиная с начала года

if month == 1
  number = day
else
  for i in 1..month - 1 do
    number += months[i]
  end
  number += day
end

puts number
