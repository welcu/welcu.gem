module Welcu
  class Contact < Base
    # property :first_name
    # property :last_name
    # property :email
  end

  module API
    module Contacts
      extend ActiveSupport::Concern

      module InstanceMethods
        def contacts
          @contacts ||= Proxy.new(self)
        end
      end

      class Proxy < API::Proxy
        def initialize(client, list = nil, contacts = nil)
          super(client)
          @list = list
          @target = with_client do
            contacts && contacts.map do |contact|
              ::Welcu::Contact.new(contact)
            end
          end
        end

        protected
          def target
            # TODO
            @target ||= []
          end
      end
    end
  end
end

