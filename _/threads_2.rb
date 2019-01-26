def sub1
  i=0
  while
    i = rand(10) + i
    # puts "In thread" 
  end # while
end # sub1
th = Thread.new{sub1}
th1 = Thread.new{sub1}
th2 = Thread.new{sub1}
p Thread.list
th.join
# UWAGA: 
#   ps -M  (Mac)
#   ps -LM (Linux)

