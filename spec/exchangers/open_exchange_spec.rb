require 'spec_helper'

describe CurrencyExchange::Exchangers::OpenExchange do
  
  describe "#convert" do
    let(:aud) { "AUD" }
    let(:aud_rate) { 4 }
    let(:usd) { "USD" }
    let(:usd_rate) { 2 }
    let(:rates) { { aud => aud_rate, usd => usd_rate } }
    let(:number) { 10 }
    let(:calculated_rate) { number * usd_rate * ( 1 / aud_rate ) }
    let(:open_exchange) { CurrencyExchange::Exchangers::OpenExchange.new }
      
    subject { open_exchange.convert(number, aud, usd) }

    before do
      open_exchange.stub(:rates).and_return(rates)
    end

    it "should return exchanged rate" do
      subject.should == calculated_rate 
    end

    context "when from/to country code is lowercase" do
      subject { open_exchange.convert(number, "aud", "usd") }

      it "should return exchanged rate" do
        subject.should == calculated_rate
      end
    end

    context "when country code is not in rates" do
      subject { open_exchange.convert(number, "ad", "usd") }
      
      it { should == nil }
    end
  end

  describe "#rates" do
    let(:url) { CurrencyExchange::Exchangers::OpenExchange::LATEST_EXCHANGE_URL }
    let(:rates) { { "AED" => 3.1 } }
    let(:data) { { "disclaimer" => 'abc', "rates" => rates } }
    let(:transporter) { mock(CurrencyExchange::Transporters::ExchangeTransporter, :retrieve_rates => data) }
    let(:open_exchange) { CurrencyExchange::Exchangers::OpenExchange.new }

    subject { open_exchange.send(:rates) }
    
    before do
      CurrencyExchange::Transporters::ExchangeTransporter.stub(:new).and_return(transporter)
    end

    it "should call transporter" do
      transporter.should_receive(:retrieve_rates).with(url)
      subject
    end

    it "should retrieve rates from data" do
      subject.should == rates
    end

    context "when data is empty" do
      let(:data) { {} }

      it { should == nil }
    end

  end

end
