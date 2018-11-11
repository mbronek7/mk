p = Proc.new { puts "Hello World" }

p.call  # prints 'Hello, world!'
p.class # returns 'Proc'
a = p   # a now equals p, a Proc instance
p       
# returns a proc object '<Proc:0x007f96b1a60eb0@(irb):46>'

#{ puts "Hello World"}       # syntax error  
#a = { puts "Hello World"}   # syntax error
[1,2,3].each {|x| puts x*2} # only works as part of the syntax of a method call

def multiple_procs(proc1, proc2)
  proc1.call
  proc2.call
end

a = Proc.new { puts "First proc" }
b = Proc.new { puts "Second proc" }

multiple_procs(a,b)
