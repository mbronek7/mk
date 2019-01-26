print_monitor = Monitor.new
q = SizedQueue.new 100 # change to SizedQueue
producer = Thread.new {
  c = 0
  100000.times do
    q << c
    c += 1
  end # times
} # Thread.new
printer1 = Thread.new {
  while true
    puts q.size
    val = q.shift
    print_monitor.synchronize do
      puts "Thread 1: #{val}"
    end # synchronize
  end
} # Thread.new
printer2 = Thread.new {
  while true
    puts q.size
    val = q.shift
    print_monitor.synchronize do
      puts "Thread 2: #{val}"
    end # synchronize
  end # while
} # Thread.new
[producer, printer1, printer2].each { |t| t.join }

