module Welcu
  module API
    module HTTP
      extend ActiveSupport::Concern

      module InstanceMethods
        def request(verb, path, params = {})
          response = @access_token.request(verb, "#{@config.api_path}/#{path}.json", params)
          
          ActiveSupport::JSON.decode(response)
        end

        def get(path, params = {})
          request(:get, path, params)
        end

        def post(path, params = {})
          request(:post, path, params)
        end

        def put(path, params = {})
          request(:put, path, params)
        end

        def delete(path, params = {})
          request(:delete, path, params)
        end
      end
    end
  end
end
