module Welcu
  module API
    module Canvas
      SIGNATURE_ALGORITHM_NAME = /\AHMAC-SHA256\Z/i
      extend ActiveSupport::Concern

      included do
        # Canvas specific attribute delegation
        delegate :path, :locale, :event_id, :company_id, :mode, :collaborator_id, :to => :config
      end
      
      module ClassMethods
        def from_signed_request(request, options = {})
          client = Welcu::Client.new(options)
          
          
          payload = Welcu::API::Canvas.decode_request(
            request, 
            Welcu.config.merge(options).client_secret
          )
          
          new( options.merge(payload) )
        end
      end
      
      def self.decode_request(request, secret)
        signature, payload_string = request.split('.', 2)

        payload = payload_string.dup
        payload << '=' until (payload.size % 4).zero?
        payload = ActiveSupport::JSON.decode(Base64.urlsafe_decode64(payload))

        unless SIGNATURE_ALGORITHM_NAME =~ payload["algorithm"]
          raise UnknownCanvasSignatureAlgorithmError.new(payload["algorithm"])
        end

        expected_sig = OpenSSL::HMAC.hexdigest('sha256', secret, payload_string)
        
        if expected_sig != signature
          raise BadCanvasSignatureError
        end

        payload
      end

    end
  end

  class BadCanvasSignatureError < Error; end
  class UnknownCanvasSignatureAlgorithmError < Error; end
end
