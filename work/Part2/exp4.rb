print 'We have a quadratic equation of the form  a*x*x + b*x + c = 0'
puts
print 'Enter koefficient a = '
a = gets.chomp.to_i

print 'Enter koefficient b = '
b = gets.chomp.to_i

print 'Enter koefficient c = '
c = gets.chomp.to_i

discr = b*b - 4*a*c
puts
if discr < 0
  puts 'The quadratic equation has no roots'
elsif discr == 0
  puts "Root = #{-b/(2*a)}"
else
  puts "Root1 = #{(-b + Math.sqrt(discr))/(2*a)}"
  puts "Root2 = #{(-b - Math.sqrt(discr))/(2*a)}"
end
