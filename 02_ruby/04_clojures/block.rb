def explicit_block(&block)
  block.call # Same as yield
end
explicit_block { puts "Explicit block called" }
