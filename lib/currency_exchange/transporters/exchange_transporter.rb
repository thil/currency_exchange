begin
  require 'rest-client'
  require 'json'
rescue LoadError
  raise "You don't have the required gems installed"
end

module CurrencyExchange
  module Transporters
    class ExchangeTransporter

      def initialize
        @storage = CurrencyExchange::Storage::Cache.instance
      end

      def retrieve_rates(url)
        @storage.fetch(url) || @storage.store(url, fetch_json(url))
      end

      private 

      def fetch_json(url)
        response = RestClient.get(url, {:accept => :json})
        JSON.parse(response.body)
      end

    end
  end
end
