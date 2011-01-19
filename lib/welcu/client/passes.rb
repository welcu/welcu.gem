module Welcu
  class Client
    module Passes
      def passes
        @passes ||= Welcu::Client::Passes::Proxy.new(self)
      end
      
      class Proxy
        include Enumerable
        
        def initialize(client)
          @client = client
        end
        
        def find(id)
          passes.find { |p| p.id == id }
        end
        
        def [](poss)
          passes[poss]
        end
        
        def each
          passes.each { |p| yield p }
        end
        
        protected
          def passes
            @passes ||= begin
              @client.get('passes').map do |data|
                Welcu::Pass.new(@client,data['pass'])
              end
            end
          end
      end
    end
  end
  
  class Pass < Base
    attr_reader :event
    attribute :name, :description
    
    def initialize(client, attributes={})
      super
      @event = client.event
    end
  end
end
