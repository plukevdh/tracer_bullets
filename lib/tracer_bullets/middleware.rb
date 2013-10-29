require 'tracer_bullets'
require 'tracer_bullets/trace_logger'

module TracerBullets
  class Middleware
    include TracerMethods

    def initialize(app)
      @app = app
      @app.class.send :include, TracerMethods
    end

    def call(env)
      setup_tracer_bullet_start_time
      @app.call(env)
    end
  end
end