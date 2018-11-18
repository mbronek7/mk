load 'application.rb'
require "rack/test"

describe Application do
  let(:app) { Application.new }

  context "get to /some/url" do
    let(:response) { get "/some/url" }
    it { expect(response.status).to eq 200 }
    it { expect(response.body).to include "/some/url, using GET" }
  end

  context "post to /" do
    let(:response) { post "/" }
    it { expect(response.status).to eq 405 }
    it { expect(response.body).to eq "Method not allowed: POST" }
  end
end
