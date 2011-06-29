module Welcu
  class Railtie < Rails::Railtie

    initializer "load configuration" do
      config_file = Rails.root.join("config", "welcu.yml")
      
      if config_file.file?
        Welcu.config.merge! YAML.load(ERB.new(config_file.read).result)[Rails.env]
      end
      
    end

  end
end if defined?(Rails) && Rails.version > '3'
