module Welcu
  class List < Base
    attr_reader :contacts

    def initialize(attributes = {}, *)
      contacts = attributes.delete('contacts') || attributes.delete(:contacts)
      @contacts = ::Welcu::API::Contacts::Proxy.new(@client, self, contacts)
      super
    end

  end

  module API
    module Lists
      extend ActiveSupport::Concern

      module InstanceMethods
        def lists
          @lists ||= Proxy.new(self)
        end
      end

      class Proxy < API::Proxy
        def find(id)
          with_client do
            ::Welcu::List.new(
             @client.get "company/contacts/lists/#{id}"
            )
          end
        end

        protected
          def target
            @target ||= with_client do
              @client.get(
                'company/contacts/lists'
              ).map do |list|
                ::Welcu::List.new(list)
              end
            end
          end
      end
    end
  end
end
