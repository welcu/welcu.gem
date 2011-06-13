module Welcu
  class Client
    module Event
      def event
        @event ||= Welcu::Event.new(self).load!
      end
      
      def company
        event.company
      end
    end
  end
  
  class Event < Base
    attr_accessor :company
    attr_accessor :passes
    
    attribute :name, :created_at
    
    def load!
      @attributes = client.get('event')
      self.company = Welcu::Company.new(self, @attributes.delete('company'))
      self.passes = client.passes
      self.company.event = self
      self
    end

  end
  
  class Company < Base
    attr_accessor :event
    attribute :name, :created_at
  end
end
