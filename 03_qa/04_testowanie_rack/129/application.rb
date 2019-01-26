class Application
  def call(env)
    handle_request(env["REQUEST_METHOD"], env["PATH_INFO"])
  end # call
  private
  def handle_request(method, path)
    if method == "GET"
      get(path)
    else
      method_not_allowed(method)
    end
  end # handle_request
  def get(path)
    [200, { "Content-Type" => "text/html" }, ["You have requested the path #{path}, using GET"]]
  end # get
  def method_not_allowed(method)
    [405, {}, ["Method not allowed: #{method}"]]
  end # method_not_allowed
end # Application

