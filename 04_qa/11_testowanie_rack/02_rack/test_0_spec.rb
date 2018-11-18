load 'application.rb'

describe Application do
  context "get to /some/url" do
    it "returns the body" do
      app = Application.new
      env = { "REQUEST_METHOD" => "GET", "PATH_INFO" => "/some/url" }
      response = app.call(env)
      body = response[2][0]
      expect(body).to eq "You have requested the path /some/url, using GET"
    end
  end
end
