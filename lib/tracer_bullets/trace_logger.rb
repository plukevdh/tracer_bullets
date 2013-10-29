module TracerBullets
  class TraceLogger
    extend Forwardable

    def initialize(type)
      @logger = type.new
    end

    def_delegators :@logger, :log
  end

  class RailsLogger
    def initialize
      @logger = Rails.logger
    end

    def log(msg)
      if defined?(ActiveSupport::TaggedLogging)
        @logger.tagged("TracerBullets") { |l| l.debug(msg) }
      else
        @logger.debug(msg)
      end
    end
  end

  class RackLogger
    def log(msg)
      puts msg
    end
  end
end

