class Numeric
  UNABLE_TO_EXCHANGE = "Unable to exchange"
  
  def exchange(from, to)
    exchange = CurrencyExchange.convert(self, from, to)
    exchange ? "$%.2f" % exchange : UNABLE_TO_EXCHANGE
  end
  
  def method_missing(sym, *args, &block)
    empty, from, to =  currency_string(sym)
    if CurrencyExchange.has_currency?(from, to)
      return exchange(from, to)
    else
      super.method_missing(sym, *args, &block)
    end
  end

  private
  def currency_string(method)
    method.to_s.split /(.+)_to_(.+)/
  end
end
