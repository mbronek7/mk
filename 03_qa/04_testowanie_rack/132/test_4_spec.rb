load 'application.rb'
require "rack/test"
RSpec.configure do |config|
  config.include Rack::Test::Methods
end # configure
describe Application do
  context "get to /some/url" do
    let(:app)      { Application.new }
    let(:response) { get "/some/url" }
    it { expect(response.status).to eq 200 }
    it { expect(response.body).to include "/some/url, using GET" }
  end # context
end # Application

