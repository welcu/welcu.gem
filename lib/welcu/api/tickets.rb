module Welcu
  class Ticket < Base
    def save
      return false if id
      self.attributes = @client.post 'tickets', :ticket => attributes
      true
    end

    def id
      attributes['id']
    end

    %w{first_name last_name email fields skip_delivery}.each do |attr|
      class_eval <<-EOM
        def #{attr}
          attributes['#{attr}'] rescue nil
        end
        
        def #{attr}=(value)
          attributes['#{attr}'] = value
        end
      EOM
    end
  end

  module API
    module Tickets
      extend ActiveSupport::Concern

      module InstanceMethods
        def tickets
          @tickets ||= Proxy.new(self)
        end
      end

      class Proxy < API::Proxy
        def find(id)
          with_client do
            ::Welcu::Ticket.new(@client.get("tickets/#{id}"))
          end
        end

        def build(attributes = {})
          with_client do
            ::Welcu::Ticket.new(attributes)
          end
        end

        protected
          def target
            # TODO: All tickets
            @target ||= []
          end
      end
    end
  end
end

