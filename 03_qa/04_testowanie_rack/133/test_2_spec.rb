ENV['RACK_ENV'] = 'test'
require_relative 'hello_world' 
require 'rspec'
require 'rack/test'
describe 'The HelloWorld App' do
  include Rack::Test::Methods
  def app
    Sinatra::Application
  end # app
  it "says hello" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to eq('Hello World')
  end # it
end # describe

