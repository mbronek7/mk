require 'tk'
class Draw
  def do_press(x, y)
    @start_x = x
    @start_y = y
    @current_line = TkcLine.new(@canvas, x, y, x, y)
  end # do_press
  def do_motion(x, y)
    if @current_line
      @current_line.coords @start_x, @start_y, x, y
    end # if
  end # do_motion
  def do_release(x, y)
    if @current_line
      @current_line.coords @start_x, @start_y, x, y
      @current_line.fill 'black'
      @current_line = nil
    end # if
  end # do_release
  def initialize(parent)
    @canvas = TkCanvas.new(parent)
    @canvas.pack
    @start_x = @start_y = 0
    @canvas.bind("1", proc{|e| do_press(e.x, e.y)})
    @canvas.bind("2", proc{ puts @canvas.postscript({}) })
    @canvas.bind("B1-Motion", proc{|x, y| do_motion(x, y)}, "%x %y")
    @canvas.bind("ButtonRelease-1", proc{|x, y| do_release(x, y)}, "%x %y")
  end # initialize
end # Draw
root = TkRoot.new{ title 'Canvas' }
Draw.new(root)
Tk.mainloop

