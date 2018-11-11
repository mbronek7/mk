require 'tk'  
TkButton.new do  
  text "Exit"  
  command { exit }  
  pack('side'=>'left', 'padx'=>10, 'pady'=>10)  
end  
Tk.mainloop  
