require 'spec_helper'

describe Numeric do
  
  describe "#exchange" do
    let(:number) { 10 }
    let(:converted) { 3 }
    let(:from) { "USD" }
    let(:to) { "AUD" }

    subject { number.exchange(from, to) }

    before do
      CurrencyExchange.stub(:convert).with(number, from, to).and_return(converted)
    end

    context "when converted value is nil" do
      let(:converted) { nil }
      it "should return unable to exchange" do
        subject.should == Numeric::UNABLE_TO_EXCHANGE
      end
    end

    it "should convert exchange value into dollar decimals" do
      subject.should == "$%.2f" % converted
    end
  end

  describe "#currency_to_currency" do
    let(:aud) { "aud" }
    let(:usd) { "usd" }
    let(:number) { 10 }

    subject { number.aud_to_usd }

    it "should call exchange with usd and aud" do
      CurrencyExchange.should_receive(:convert).with(number, aud, usd)
      subject
    end

    context "when currency doesnt exist" do
      subject { number.au_to_usd }
      it "should throw no method exception" do
        expect{subject}.to raise_error(NoMethodError)
      end
    end
  end

end
