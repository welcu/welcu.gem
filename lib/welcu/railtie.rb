return unless defined?(Rails) && Rails.version > '3'

module Welcu
  class Railtie < Rails::Railtie

    initializer "load configuration" do
      config_file = Rails.root.join("config", "welcu.yml")
      
      if config_file.file?
        Welcu.config.merge! YAML.load(config_file)[Rails.env]
      end
      
    end

  end
end
