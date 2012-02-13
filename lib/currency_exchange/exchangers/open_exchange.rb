module CurrencyExchange
  class Exchangers::OpenExchange

    LATEST_EXCHANGE_URL = "http://openexchangerates.org/latest.json"

    def initialize
      @transporter = CurrencyExchange::Transporters::ExchangeTransporter.new
    end

    def convert(number, from, to)
      number * rates[to.upcase] * ( 1 / rates[from.upcase] ) if rates[to.upcase] && rates[from.upcase]
    end

    private

    def rates
      @rates ||= @transporter.retrieve_rates(LATEST_EXCHANGE_URL)['rates']
    end

  end
end
