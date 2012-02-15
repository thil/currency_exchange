require 'spec_helper'

describe CurrencyExchange::Storage::RailsCache do

  describe "#fetch" do
    let(:cache_data) { "my data" }
    let(:key) { 123 }

    subject { CurrencyExchange::Storage::RailsCache.new.fetch(key) }

    before do
      Rails.stub_chain(:cache, :read).and_return(cache_data)
    end

    it "should retrieve from cache" do
      subject.should == cache_data
    end
  end

  describe "#store" do
    let(:key) { 123 }
    let(:value) { "ok" }
    subject {  CurrencyExchange::Storage::RailsCache.new.store(key, value) }

    before do
      Rails.stub_chain(:cache, :write).with(key, value, anything()).and_return(true)
    end

    it "should return back value" do
      subject.should == value
    end
  end
end
