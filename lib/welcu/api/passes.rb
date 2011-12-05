module Welcu
  class Pass < Base
    attributes :name, :location, :locale

    def save
      return false if id
      self.attributes = @client.post 'passes', :pass => attributes
      true
    end

    def starts_at
      Time.parse(attributes[:starts_at]) rescue nil
    end

    def ends_at
      Time.parse(attributes[:ends_at]) rescue nil
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

