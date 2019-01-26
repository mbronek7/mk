require "./process_lib"
require "benchmark"
threads = []
puts Benchmark.measure {
  100.times do |i|
    threads << Thread.new do     
      Mailer.deliver do 
        from    "nadawca"
        to      "adresat"
        subject "Threading and Forking (#{i})"
        body    "Some content"
      end # Mailer.deliver
    end # Thread.new
  end # 100.times
  threads.map(&:join)
} # Benchmark.measure

