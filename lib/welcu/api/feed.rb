module Welcu
  class FeedItem < Base
    attributes :kind, :label, :collaborator_id, :email, :key, :fields

    def save
      result = @client.post('feed', :item => attributes)
      case result['status']
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

