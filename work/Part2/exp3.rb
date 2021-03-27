print "Enter the first side of the triangle  "
first = gets.chomp.to_i

print "Enter the second side of the triangle  "
second = gets.chomp.to_i

print "Enter the third side of the triangle  "
third = gets.chomp.to_i

if first == second && second == third
  puts "isosceles triangle"
else
  if first > second && first > third
    max_side = first
    side1 = second
    side2 = third
  elsif second > first && second > third
    max_side = second
    side1 = first
    side2 = third
  else
    max_side = third
    side1 = first
    side2 = second
  end

  if max_side * max_side == side1 * side1 + side2 * side2
    puts "the triangle is rectangular"
  else
    puts "the triangle is not rectangular"
  end
end
