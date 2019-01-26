require 'objspace'
File.open('output.txt', 'w') do |f|
  ObjectSpace.dump_all(output: f)
end

