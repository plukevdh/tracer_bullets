require 'tracer_bullets/trace_logger'
require "active_support/concern"

module TracerBullets
  class Railtie < Rails::Railtie
    initializer "tracer_bullet.action_controller" do
      ActiveSupport.on_load(:action_controller) do
        include TracerBullets::Controller
      end
    end

    initializer "tracer_bullet.action_view" do
      ActiveSupport.on_load(:action_view) do
        include TracerBullets::View
      end
    end
  end

  module Controller
    extend ActiveSupport::Concern
    include TracerMethods

    included do
      before_filter :setup_tracer_bullet_start_time
    end
  end

  module View
    extend ActiveSupport::Concern
    include TracerMethods
  end
end