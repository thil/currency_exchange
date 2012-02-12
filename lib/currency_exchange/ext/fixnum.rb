class Numeric
  
  def exchange(from, to)
    "$%.2f" % CurrencyExchange.convert(self, from, to)
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
