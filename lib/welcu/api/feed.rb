module Welcu
  class FeedItem < Base
    attributes :kind, :key, :fields, :email, :user_id

    def save
      case @client.post('feed', attributes)['status']
      when 'OK'
        true
      else
        false
      end
    end

  end

  module API
    module Feed
      extend ActiveSupport::Concern

      module InstanceMethods
        def feed
          @feed ||= Proxy.new(self)
        end
      end

      class Proxy < API::Proxy
        def build(attributes)
          with_client do
            ::Welcu::FeedItem.new(attributes)
          end
        end

        protected
          def target
            []
          end
      end
    end
  end
end

