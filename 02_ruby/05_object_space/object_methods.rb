# Create a Range object
r = 1..10 
list = r.methods
list.length # 120
list[0..3] 

r.respond_to?("frozen?") # true
r.respond_to?("hasKey") # false
"me".respond_to?("==") # true
