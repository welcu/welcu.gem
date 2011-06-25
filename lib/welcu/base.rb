module Welcu
  class Base < Hashie::Mash
    # property :id

    def client=(client)
      @client = client
    end

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
