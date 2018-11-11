proc = Proc.new { puts "Hello world" }
lam = lambda { puts "Hello World" }

proc.class # returns 'Proc'
lam.class  # returns 'Proc'

proc   
# returns '#<Proc:0x007f96b1032d30@(irb):75>'
lam    
# returns '<Proc:0x007f96b1b41938@(irb):76 (lambda)>'

# creates a lambda that takes 1 argument
lam = lambda { |x| puts x }    
lam.call(2)                    # prints out 2
# ArgumentError: wrong number of arguments (0 for 1)
#lam.call       
# ArgumentError: wrong number of arguments (3 for 1)
#lam.call(1,2,3)

# creates a proc that takes 1 argument
proc = Proc.new { |x| puts x } 
proc.call(2)                   # prints out 2
proc.call                      # returns nil
# prints out 1 and forgets about the extra arguments
proc.call(1,2,3)   

def lambda_test
  lam = lambda { return }
  lam.call
  puts "Hello world"
end
# calling lambda_test prints 'Hello World'
lambda_test    

def proc_test
  proc = Proc.new { return }
  proc.call
  puts "Hello world"
end
# calling proc_test prints nothing
proc_test      
