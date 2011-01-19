module Welcu
  class API
    attr_reader :client_id , :client_secret , :welcu_uri , :access_token , :consumer , :auth, :api_path
    alias_method :id, :client_id
    alias_method :secret, :client_secret
      
    def initialize(options = {})
      options = Welcu.config.merge(options)
      @client_id, @client_secret = options['client_id'], options['client_secret']
      @welcu_uri = options['welcu_uri']
      @api_path = options['api_path']
      @access_token = options.fetch :access_token, nil
      @auth = OAuth2::AccessToken.new(oauth_client , @access_token)
    end
    
    def access_token=(new_token)
      @access_token = new_token
      @auth = OAuth2::AccessToken.new(oauth_client , @access_token)
      new_token
    end
    
    def oauth_client
      OAuth2::Client.new(client_id, client_secret, :site => welcu_uri)
    end
    
    %w{get post put delete}.each do |method|
      class_eval <<-EOM
        def #{method}(path, *args)
          JSON.parse( auth.#{method}(api_path+'/'+path+'.json',*args) )
        end
      EOM
    end
  end  
end
