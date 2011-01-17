# require 'rubygems'
# require "bundler/setup"
require 'active_support/all'
require 'oauth2'
require 'json'
# require 'hashie'
#require 'rest_client'
require 'uri'
require "base64"
require "openssl"

# require 'welcu/result'
require 'welcu/error'
require 'welcu/base'
require 'welcu/api'
require 'welcu/client'
# require 'welcu/base'
# require 'welcu/authorization'
# require 'welcu/selection'
# require 'welcu/search'
# require 'welcu/realtime'

module Welcu
  DEFAULT_CONFIG = {
    :welcu_uri => 'https://backstage.welcu.com',
    :api_path => '/api/v1'
  }.freeze
  @config = DEFAULT_CONFIG

  class << self

    def load_config(yaml_file, scope = nil)
      cfg = YAML::load(File.open(yaml_file))
      if scope
        cfg = cfg[scope]
      end
      
      config(cfg)
    end

    def config(values=nil)
      if values
        @config = @config.merge(values).freeze
      end
      
      @config
    end
  end
end