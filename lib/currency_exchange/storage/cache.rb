module CurrencyExchange
  class Storage::Cache

    CACHE_STRATEGY = { :rails_cache => CurrencyExchange::Storage::RailsCache }

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
      (CACHE_STRATEGY[cache_strategy] || self).new
    end

  end
end

