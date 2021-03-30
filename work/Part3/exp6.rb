products = {}

loop do
  puts "Enter name product"
  product = gets.chomp
  break if product == "stop"
  puts "Enter price product unit"
  price = gets.chomp.to_f
  puts "Enter quantity product"
  quantity = gets.chomp.to_f
  if products[product].nil?
    products[product] = price * quantity
  else
    products[product] += price * quantity
  end
end

if products.empty?
  puts "The products were not purchased"
else
  total_sum = 0
  products.each do |product, price|
    puts "#{product}: #{price}"
    total_sum += price
  end
  puts "Total summa = #{total_sum}"
end
