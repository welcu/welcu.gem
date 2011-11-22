module Welcu
  class Pass < Base
    attributes :name, :location, :starts_at, :ends_at

    def save
      return false if id
      self.attributes = @client.post 'passes', :pass => attributes
      true
    end

  end

  module API
    module Passes
      extend ActiveSupport::Concern

      module InstanceMethods
        def passes
          @passes ||= Proxy.new(self)
        end
      end

      class Proxy < API::Proxy
        def find(id)
          target.find { |pass| pass.id == id}
        end

        def build(attributes = {})
          with_client do
            ::Welcu::Pass.new(attributes)
          end
        end

        protected
          def target
            @target ||= with_client do
              @client.get('passes').map do |pass|
                ::Welcu::Pass.new(pass)
              end
            end
          end
      end

    end
  end
end

