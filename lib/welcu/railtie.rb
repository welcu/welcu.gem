yaml_file = Rails.root.join('config/welcu.yml')
Welcu.load_config(yaml_file,Rails.env) if File.exist?(yaml_file)
