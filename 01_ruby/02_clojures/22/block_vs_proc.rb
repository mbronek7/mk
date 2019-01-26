p = Proc.new { puts "Hello, world!" }

p.call  # Wyświetla 'Hello, world!'
p.class # Zwraca 'Proc'
a = p   # a równe p, instancji Proc
p       
# Zwraca obiekt klasy Proc '<Proc:0x007f96b1a60eb0@(irb):46>'

# { puts "Hello World"}       # syntax error  
# a = { puts "Hello World"}   # syntax error
[1,2,3].each {|x| puts x*2} 

def multiple_procs(proc1, proc2)
  proc1.call
  proc2.call
end

a = Proc.new { puts "First proc" }
b = Proc.new { puts "Second proc" }

multiple_procs(a,b)

