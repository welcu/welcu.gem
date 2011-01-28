module Welcu
  class Client
    module Notifications
      def notify(notification)
        self.post('notifications', :notification => notification)
      end
    end
  end
end
