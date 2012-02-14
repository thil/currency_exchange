begin
  require 'rest-client'
  require 'json'
rescue LoadError
  raise "You don't have the required gems installed"
end

module CurrencyExchange
  module Transporters
    class JsonTransporter < ExchangeTransporter

      def fetch_data(url)
        response = RestClient.get(url, {:accept => :json})
        JSON.parse(response.body)
      end

    end
  end
end

