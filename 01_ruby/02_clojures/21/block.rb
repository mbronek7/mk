def explicit_block(&block)
  block.call # Równoznaczne z yield
end
explicit_block { puts "Explicit block called" }

def do_something_with_block
  return "No block given" unless block_given?
  yield
end

