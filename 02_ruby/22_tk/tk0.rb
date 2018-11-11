require 'tk'  
hello = TkRoot.new do  
  title "Sample window"  
  # the min size of window  
  minsize(300,200)  
end  
TkLabel.new(hello) do  
  text 'Hello, world!'  
  foreground 'black'  
  pack { padx 15; pady 15; side 'left'}  
end  
Tk.mainloop 
