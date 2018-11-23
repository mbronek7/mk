class Counter
  def initialize(init)
    @fiber = Fiber.new do
      n = init
      loop do
        Fiber.yield n
        n += 1
      end
    end
  end

  def next
    @fiber.resume
  end
end

counter = Counter.new(0)
puts counter.next
#=> 0
puts counter.next
#=> 1
puts counter.next
#=> 2
