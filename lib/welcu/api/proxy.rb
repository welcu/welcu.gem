module Welcu
  module API

    class Proxy < BasicObject
      def initialize(client)
        @client = client
      end
      
      protected
        def method_missing(name, *args, &block)
          target.send(name, *args, &block)
        end
    end 

  end
end
