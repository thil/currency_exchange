begin
  require 'rest-client'
  require 'json'
rescue LoadError
  raise "You don't have the required gems installed"
end

module CurrencyExchange
  module Transporters
    class ExchangeTransporter

      def retrieve_rates(url)
        fetch_json(url)
      end

      def fetch_json(url)
        response = RestClient.get(url, {:accept => :json})
        JSON.parse(response.body)
      end

    end
  end
end
