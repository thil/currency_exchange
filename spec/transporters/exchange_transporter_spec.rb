require 'spec_helper'

describe CurrencyExchange::Transporters::ExchangeTransporter do

  describe "#load_instance" do
    let(:strategy) { nil }
    subject { CurrencyExchange::Transporters::ExchangeTransporter.load_instance(strategy) }

    context "when strategy is to use json" do
      let(:strategy) { :json }

      it "should return json transporter" do
        subject.class.should == CurrencyExchange::Transporters::ExchangeTransporter::TRANSPORTER_STRATEGY[:json]
      end
    end

    it "should return an instance of itself" do
      subject.class.should == CurrencyExchange::Transporters::ExchangeTransporter
    end
  end

  describe "#fetch_data" do
    let(:url) { "http://www.blah.com" }

    subject { CurrencyExchange::Transporters::ExchangeTransporter.new.fetch_data(url) }
    it "should throw a not implemented error" do
      expect { subject }.to raise_error(NotImplementedError)
    end
  end

  describe "#retrieve_rates" do
    let(:url) { "http://www.blah.com" }
    let(:fetch_data) { "fetched data" }
    let(:store_data) { "store data" }
    let(:storage) { mock('storage', :fetch => fetch_data, :store => store_data) }
    let(:transporter) { CurrencyExchange::Transporters::ExchangeTransporter.new }

    subject { transporter.retrieve_rates(url) }

    before do
      CurrencyExchange::Storage::Cache.stub(:instance).and_return(storage)
      transporter.stub(:fetch_data)
    end

    it "should return data in storage" do
      subject.should == fetch_data
    end

    context "when fetch data is nil" do
      let(:fetch_data) { nil }

      it "should store and return data" do
        subject.should == store_data
      end
    end
  end
  
end

