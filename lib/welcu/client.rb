module Welcu
  class Client
    delegate :client_id, :client_secret, :access_token, :to => :config
    alias_method :id, :client_id
    alias_method :secret, :client_secret

    def initialize(config = {})
      @config = Welcu.config.merge(config)
      self.access_token = @config.access_token if @config.access_token
    end

    def access_token=(new_token)
      config.access_token = new_token
      @access_token = OAuth2::AccessToken.new(oauth_client , new_token)
      @access_token.token_param = 'access_token'
    end

    protected
      def config
        @config
      end

      def oauth_client
        OAuth2::Client.new(config.client_id, config.client_secret, :site => config.api_uri)
      end
  end  
end
