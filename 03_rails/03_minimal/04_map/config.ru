map '/posts' do
  run Proc.new { |env| ['200', {
      'Content-Type' => 'text/html'}, ['first_post', 'second_post', 'third_post']] 
  }
end
