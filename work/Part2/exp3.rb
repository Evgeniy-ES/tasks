print 'Enter the first side of the triangle  '
first = gets.chomp.to_i

print 'Enter the second side of the triangle  '
second = gets.chomp.to_i

print 'Enter the third side of the triangle  '
third = gets.chomp.to_i

if first == second && second == third
  puts 'isosceles triangle'
else
  a, b, hypo = [first, second, third].sort

  if hypo ** 2 == a ** 2 + b ** 2
    puts 'the triangle is rectangular'
  else
    puts 'the triangle is not rectangular'
  end
end
