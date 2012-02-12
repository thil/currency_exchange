require 'spec_helper'

describe CurrencyExchange::Data::Currencies do

  describe "#has_currency?" do
    let(:from) { "USD" }
    let(:to) { "AUD" }
    subject { CurrencyExchange::Data::Currencies.has_currency?(from, to) }

    context "when from currency is nil" do
      let(:from) { nil }
      it { should == false }
    end

    context "when to currency is nil" do
      let(:to) { nil }
      it { subject.should == false }
    end

    context "when from currency does not exist in currencies list" do
      let(:from) { "EEE" }
      it { subject.should == false }
    end

    context "when to currency does not exist in currencies list" do
      let(:to) { "EEE" }
      it { subject.should == false }
    end

    it "should return true when from and to currencies exist" do
      subject.should == true
    end
  end
  
end
