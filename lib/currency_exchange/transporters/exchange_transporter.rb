begin
  require 'rest-client'
  require 'json'
rescue LoadError
  raise "You don't have the required gems installed"
end

module CurrencyExchange
  module Transporters
    class ExchangeTransporter

      TRANSPORTER_STRATEGY = { :json => CurrencyExchange::Transporters::JsonTransporter }

      def initialize
        @storage = CurrencyExchange::Storage::Cache.instance
      end

      def retrieve_rates(url)
        @storage.fetch(url) || @storage.store(url, fetch_data(url))
      end

      def fetch_data(url)
        raise NotImplementedError.new("fetch_data")
      end

      def self.load_instance(transporter_strategy)
        (TRANSPORTER_STRATEGY[transporter_strategy] || self).new
      end
    end
  end
end
