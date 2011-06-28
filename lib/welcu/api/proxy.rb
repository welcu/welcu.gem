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

        # Handy wrapper to add a reference to the client on every proxyed object
        def with_client
          object = yield

          if object.respond_to? :client=
            object.client = @client
          elsif object.is_a? Array
            object.each do |o|
              o.client = @client if o.respond_to? :client=
            end
          end

          object
        end
    end 

  end
end
