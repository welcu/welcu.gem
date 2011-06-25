module Welcu
  class Pass < Base
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

        protected
          def target
            @target ||= @client.get('passes').map do |pass|
              ::Welcu::Pass.new(pass).tap { |p| p.client = @client }
            end
          end
      end

    end
  end
end

