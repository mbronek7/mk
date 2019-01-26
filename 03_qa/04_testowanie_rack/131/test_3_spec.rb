load 'application.rb'
require "rack/test"
describe Application do
  include Rack::Test::Methods
  context "get to /some/url" do
    let(:app)      { Application.new }
    let(:response) { get "/some/url" }
    it { expect(response.status).to eq 200 }
    it { expect(response.body).to include "/some/url, using GET" }
  end # context
end # Application

