module CurrencyExchange
  class Storage::Cache

    class << self
      attr_accessor :cache_strategy

      def instance
        @instance ||= load_instance
      end
    end

    def fetch(key)
    end

    def store(key, value)
      value
    end

    private

    def self.load_instance
      if self.cache_strategy == :memcache
        CurrencyExchange::Storage::MemCache.new
      else
        self.new
      end
    end

  end
end

