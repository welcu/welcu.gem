module Welcu
  class Base
    attr_reader :client
    attr_accessor :attributes
    
    def initialize(client, attributes={})
      @client = client
      @attributes = attributes
    end
    
    def self.attribute(*names)
      names.each do |name|
        self.class_eval <<-EOF
          def #{name}
            attributes['#{name}']
          end
        
          def #{name}=(value)
            attributes['#{name}'] = value
          end
        EOF
      end
    end
    attribute :id
    
    def to_hash
      { self.class.name.gsub('Welcu::','').downcase => attributes }
    end
  end
end