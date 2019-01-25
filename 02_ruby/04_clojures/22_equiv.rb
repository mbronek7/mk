[1,2,3].map(&:to_s)
[1,2,3].map {|i| i.to_s }
[1,2,3].map {|i| i.send(:to_s) }

