begin 
  require 'rails'
rescue LoadError
  raise "You don't have rails installed"
end

module CurrencyExchange
  class Storage::MemCache < Storage::Cache

    def fetch(key)
      Rails.cache.read(key)
    end
      
    def store(key, value)
      Rails.cache.write(key, value, :expires_in => 1.day)
      value
    end
  end
end
