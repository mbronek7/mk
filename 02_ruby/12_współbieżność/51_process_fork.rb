require "./47_process_lib"
require "benchmark"
puts Benchmark.measure {
  100.times do |i|
    fork do     
      Mailer.deliver do 
        from    "nadawca"
        to      "adresat"
        subject "Threading and Forking (#{i})"
        body    "Some content"
      end # Mailer.deliver
    end # fork
  end # 100.times
  Process.waitall
} # Benchmark.measure

