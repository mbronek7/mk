use Rack::Auth::Basic, "Restricted Area" do |username, password|
  [username, password] == ['admin', 'abc123']
end

run Proc.new { |env| ['200', {'Content-Type' => 'text/html'}, ['get rack\'d']] }
