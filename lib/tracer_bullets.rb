require "tracer_bullets/version"

module TracerBullets
  module TracerMethods
    def setup_tracer_bullet_start_time
      @app ||= self
      @app.instance_variable_set :@tracer_bullet_start_time, Time.now
    end

    def trace_logger
      @logger ||= TraceLogger.new (defined?(Rails) ? RailsLogger : RackLogger)
    end

    def tracer_bullet
      if ENV['RACK_ENV'] == "development"
        trace_logger.log("Elapsed: #{((Time.now - @tracer_bullet_start_time)*1000).to_i}ms #{caller(0)[1]}" )
        @tracer_bullet_start_time = Time.now
      end
    end
    alias_method :tb, :tracer_bullet

  end
end

require 'tracer_bullets/railtie' if defined?(Rails)