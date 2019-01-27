proc = Proc.new { puts "Hello world" }
lam = lambda { puts "Hello World" }

proc.class # Zwraca 'Proc'
lam.class  # Zwraca 'Proc'

proc   
# Zwraca '#<Proc:0x007f96b1032d30@(irb):75>'
lam    
# Zwraca '<Proc:0x007f96b1b41938@(irb):76 (lambda)>'

# Zworzy lamba z jednym argumentem
lam = lambda { |x| puts x }    
lam.call(2)                    # Wyświetla 2
# ArgumentError: wrong number of arguments (0 for 1)
lam.call       
# ArgumentError: wrong number of arguments (3 for 1)
lam.call(1,2,3)

# tworzy Proc z jednym argumentem
proc = Proc.new { |x| puts x } 
proc.call(2)                   # Wyświetla 2
proc.call                      # Zwraca nil
# Wyświetla 1, pomijając pozostałe argumenty
proc.call(1,2,3)   

def lambda_test
  lam = lambda { return }
  lam.call
  puts "Hello world"
end
# Wywołanie lambda_test wyświetla 'Hello world'
lambda_test    

def proc_test
  proc = Proc.new { return }
  proc.call
  puts "Hello world"
end
# Wywołanie proc_test nic nie wyświetla
proc_test      

