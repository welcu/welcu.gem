module Welcu
  class Event < Base
    # property :name
    # property :created_at
    # property :company

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
