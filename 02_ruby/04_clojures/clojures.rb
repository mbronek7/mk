# Block Examples

# block is in between the curly braces
[1,2,3].each { |x| puts x*2 } 

# block is everything between the do and end
[1,2,3].each do |x|
  puts x*2                    
end

# Proc Examples             
p = Proc.new { |x| puts x*2 }
# The '&' tells ruby to turn the proc into a block 
[1,2,3].each(&p)              

# The body of the Proc object gets executed when called
proc = Proc.new { puts "Hello World" }
proc.call                     

# Lambda Examples            
lam = lambda { |x| puts x*2 }
[1,2,3].each(&lam)

lam = lambda { puts "Hello World" }
lam.call
