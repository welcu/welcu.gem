require 'welcu/api/proxy'
Dir[File.expand_path('../api/*.rb', __FILE__)].each{|f| require f}

module Welcu
  class Client
    include Welcu::API::HTTP
    include Welcu::API::Canvas
    include Welcu::API::Event
    include Welcu::API::Lists
    include Welcu::API::Contacts
    include Welcu::API::Passes
    include Welcu::API::Tickets
    include Welcu::API::Feed
  end  
end
