require "./process_lib"
require "benchmark"
puts Benchmark.measure {
  100.times do |i|
    Mailer.deliver do 
      from    "nadawca"
      to      "adresat"
      subject "Threading and Forking (#{i})"
      body    "Some content"
    end # Mailer.deliver
  end # 100.times
} # Benchmark.measure

