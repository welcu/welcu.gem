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
    
    attribute :name, :short_name, :permalink, :description, :starts_at, :ends_at, :locale, :logo, :location, :url, :logo_big
    
    def load!
      @attributes = client.get('event')['event']
      self.company = Welcu::Company.new(self, @attributes.delete('company'))
      self.company.event = self
      self
    end
  end
  
  class Company < Base
    attr_accessor :event
    attribute :name, :short_name, :permalink, :description, :locale
  end
end
