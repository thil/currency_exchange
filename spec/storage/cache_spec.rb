require 'spec_helper'

describe CurrencyExchange::Storage::Cache do

  describe "#cache_strategy" do
    let(:cache_strategy) { :ok }
    
    before do
      CurrencyExchange::Storage::Cache.cache_strategy = cache_strategy 
    end

    it "should set a cache strategy" do
      CurrencyExchange::Storage::Cache.cache_strategy.should == cache_strategy
     end
  end

  describe "#load_instance" do
    let(:cache_strategy) { nil }
    subject { CurrencyExchange::Storage::Cache.send(:load_instance) }

    before do
      CurrencyExchange::Storage::Cache.cache_strategy = cache_strategy 
    end

    it "should return self" do
      subject.class.should == CurrencyExchange::Storage::Cache
    end

    context "when strategy is to rails cache" do
      let(:cache_strategy) { :rails_cache }

      it "should return rails cache storage" do
         subject.class.should == CurrencyExchange::Storage::RailsCache
      end
    end
  end

  describe "#store" do
    let(:key) { "abc" }
    let(:value) { 10 }
    subject { CurrencyExchange::Storage::Cache.new.store(key, value) }

    it "should not store and return value" do
      subject.should == value 
    end
  end
  
end

