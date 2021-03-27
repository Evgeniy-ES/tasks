print "Enter your name "
weight = gets.chomp
weight = weight.capitalize!

print "Enter your height "
height = gets.chomp.to_i

ideal_weight =  (height - 110) * 1.15

if ideal_weight < 0
  print "Your weight is already optimal"
else
  puts "Your iseal weight = #{ideal_weight}"
end
