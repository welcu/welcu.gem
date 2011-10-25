module Welcu
  class Contact < Base
    attributes :first_name, :last_name, :email, :custom_fields
    
    def field(key)
      return nil unless custom_fields.kind_of?(Array)
      
      value = nil
      custom_fields.each do |f|
        if f['key'] == key
          value = f['value']
          break
        end
      end
      
      value
    end
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

