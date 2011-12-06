module Welcu
  class Event < Base
    attributes :name, :created_at, :company, :timezone, :locale, :starts_at, :ends_at

    def initialize(*)
      super
      self.company = Welcu::Company.new(company) if company
    end

  end
  
  module API
    module Event
      extend ActiveSupport::Concern

      module InstanceMethods
        def event
          @event ||= Welcu::Event.new get('event')
        end

        def company
          event.company
        end

      end
      
    end
  end
end
