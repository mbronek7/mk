load 'application.rb'

describe Application do
  context "get to /ruby/monstas" do
    let(:app)      { Application.new }
    let(:env)      { { "REQUEST_METHOD" => "GET", "PATH_INFO" => "/some/url" } }
    let(:response) { app.call(env) }
    let(:status)   { response[0] }
    let(:body)     { response[2][0] }
    it "returns the status 200" do
      expect(status).to eq 200
    end # it
    it "returns the body" do
      expect(body).to eq "You have requested the path /some/url, using GET"
    end # it
  end # context
end # Application

