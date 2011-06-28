module Welcu
  class Base

    def initialize(attributes = {})
      self.attributes = Hashie::Mash.new(attributes)
    end

    def attributes
      @attributes
    end

    def attributes=(attributes)
      @attributes = Hashie::Mash.new(attributes)
    end

    def client=(client)
      @client = client
    end

    def inspect
      @attributes.inspect.gsub /Hashie::Mash/, self.class.name
    end

    class << self
      def attributes(*names)
        # Getters & Setters
        delegate *names, :to => :attributes
        delegate *names.map { |attr| "#{attr}="}, :to => :attributes
      end
    end
    attributes :id
  end
end
