begin 
  require 'rails'
rescue LoadError
  raise "You don't have required libraries installed"
end

module CurrencyExchange
  module Storage
    class RailsCache < Cache

      def fetch(key)
        Rails.cache.read(key)
      end
      
      def store(key, value)
        Rails.cache.write(key, value, :expires_in => 86400)
        value
      end
    end
  end
end
