module Welcu
  class Contact < Base
    attributes :first_name, :last_name, :email, :unsubscribed, :custom_fields

    def save
      # return false unless id
      self.attributes = @client.put "company/contacts/#{id}", { id: id, contact: attributes }
      true
    end

    def unsubscribed?
      attributes.unsubscribed
    end

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

    def client=(c)
      @client = c
    end

    def client
      @client
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

