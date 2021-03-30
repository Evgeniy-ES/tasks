fibo_array = []
i = 0
loop do
  fibo_array << i
  if i == 0
    i = 1
  else
    i = fibo_array[-1] + fibo_array[-2]
  end
  break if i > 100
end
puts fibo_array
