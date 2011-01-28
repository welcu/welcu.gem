module Welcu
  
  class Client < API
    Dir[File.expand_path('../client/*.rb', __FILE__)].each{|f| require f}
    
    include Welcu::Client::Canvas
    include Welcu::Client::Event
    include Welcu::Client::Passes
    include Welcu::Client::Registries
    include Welcu::Client::Notifications
    
  end  
end
