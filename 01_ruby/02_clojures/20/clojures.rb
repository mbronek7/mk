# Przy bloku stosujemy nawiasy klamrowe
[1,2,3].each { |x| puts x*2 } 
# Jak również do i end
[1,2,3].each do |x|
  puts x*2                    
end

# Przykłady Proc
p = Proc.new { |x| puts x*2 }
# Znak & powoduje konwersję Proc na blok
[1,2,3].each(&p)              
# Metoda call uruchamia treść Proc
proc = Proc.new { puts "Hello, world!" }
# Wywołanie call
proc.call              
       
# Przykłady Lambda
lam = lambda { |x| puts x*2 }
# Konwersja
[1,2,3].each(&lam)
# Lub
lam = lambda { puts "Hello, world!" }
# Wywołanie call
lam.call

