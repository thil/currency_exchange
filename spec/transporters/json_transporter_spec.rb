require 'spec_helper'

describe CurrencyExchange::Transporters::JsonTransporter do

  describe "#fetch_data" do
    let(:url) { "http://www.blah.com" }
    let(:body) { '{"one":true}' }
    let(:json) { { 'one' => true } }
    let(:response) { mock("response", :body => body) }

    subject { CurrencyExchange::Transporters::JsonTransporter.new.fetch_data url }

    before do
      RestClient.stub(:get).and_return(response)
    end

    it "should call rest client" do
      RestClient.should_receive(:get).with(url, anything())
      subject
    end

    it "should retrieve body of response" do
      subject.should == json
    end
  end
  
end


