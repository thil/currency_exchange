require "currency_exchange/version"
require 'currency_exchange/ext/fixnum'

module CurrencyExchange
  module Exchangers
    autoload :OpenExchange, 'currency_exchange/exchangers/open_exchange'
  end

  module Transporters
    autoload :JsonTransporter, 'currency_exchange/transporters/json_transporter'
    autoload :ExchangeTransporter, 'currency_exchange/transporters/exchange_transporter'
  end

  module Data
    autoload :Currencies, 'currency_exchange/data/currencies'
  end

  module Storage
    autoload :RailsCache, 'currency_exchange/storage/rails_cache'
    autoload :Cache, 'currency_exchange/storage/cache'
  end

  class << self
    def convert(number, from, to)
      exchanger.convert(number, from, to) if has_currency?(from, to)
    end

    def has_currency?(from, to)
      CurrencyExchange::Data::Currencies.has_currency?(from, to)
    end

    private
    def exchanger
      @exchanger ||= CurrencyExchange::Exchangers::OpenExchange.new
    end
  end 
end
