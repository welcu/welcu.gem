module Welcu
  class Client
    module Registries
      def registries
        @registries ||= Welcu::Client::Registries::Proxy.new(self)
      end
      
      class Proxy
        def initialize(client)
          @client = client
        end
        
        def find(id)
          data = @client.get("registries/#{id}")
          Welcu::Registry.new(@client,data['registry'])
        end
        
        def build(attributes = {})
          Welcu::Registry.new(@client,attributes)
        end
      end
    end
  end
  
  class Registry < Base
    attr_reader :event
    attribute :first_name, :last_name, :email, :phone, :pass_id, :state, :fields, :verification, :message
    
    def initialize(client, attributes={})
      super
      @event = client.event
    end
    
    def pass
      if pass_id
        @pass ||= client.passes.find(pass_id)
      end
    end
    
    def pass=(pass)
      @pass = pass
      self.pass_id = pass && pass.id
    end
    
    def save
      if id
        client.put("registries/#{id}", to_hash)
      else
        self.id = client.post("registries", to_hash)['registry']['id']
      end
      
      true
    end
    
    def confirm!
      client.put("/registries/#{id}/confirm")
      true
    end
    
    def reject!
      client.put("/registries/#{id}/reject")
      true
    end
  end
end
