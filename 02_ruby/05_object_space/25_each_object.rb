a = 102.7
b = 95       # Nie zostanie zwrócone
c = 12345678987654321
count = ObjectSpace.each_object(Numeric) {|x| p x }
puts "Total count: #{count}"

