module Welcu
  class Railtie < Rails::Railtie
    initializer "load configuration" do
      config_file = Rails.root.join("config", "welcu.yml")
      Welcu.load_config(config_file,Rails.env) if config_file.file?
    end
  end
end if Rails.version > '3'
