require 'tk'  
hello = TkRoot.new do  
  title "Sample window"  
  # Minimalny rozmiar okna
  minsize(300,200)  
end # TkRoot.new
TkLabel.new(hello) do  
  text 'Hello, world!'  
  foreground 'black'  
  pack { padx 15; pady 15; side 'left'}  
end # TkLabel.new
Tk.mainloop 

