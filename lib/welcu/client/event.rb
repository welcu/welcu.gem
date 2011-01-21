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
    
    attribute :name, :short_name, :permalink, :description, :starts_at, :ends_at, :locale, :logo, :location, :url, :logo_big
    
    def load!
      @attributes = client.get('event')['event']
      self.company = Welcu::Company.new(self, @attributes.delete('company'))
      self.passes = client.passes
      self.company.event = self
      client.locale ||= self.locale
      self
    end

  end
  
  class Company < Base
    attr_accessor :event
    attribute :name, :short_name, :permalink, :description, :locale
  end
end
