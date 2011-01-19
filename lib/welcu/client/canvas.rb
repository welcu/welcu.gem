require 'base64'

module Welcu
  class Client
    module Canvas
      def self.included(receiver)
        receiver.extend         ClassMethods
      end
      
      module ClassMethods
        def from_signed_request(request, options = {})
          client = Welcu::Client.new(options)
          signature, payload = request.split('.', 2)
          
          data = Welcu::Client::Canvas.decode_payload(payload)
          
          if data['algorithm'].to_s.upcase != 'HMAC-SHA256'
            raise Welcu::Client::Canvas::BadSignatureAlgorithmError.new(data['algorithm'])
          end
          expected_sig = OpenSSL::HMAC.hexdigest('sha256', client.secret, payload)
          
          if expected_sig != signature
            raise Welcu::Client::Canvas::BadSignatureError
          end
          
          client.access_token = data['access_token']
          
          client
        end
      end
      
      def self.decode_payload(payload)
        payload = payload.dup
        payload << '=' until (payload.size % 4).zero?
        JSON.parse(Base64.urlsafe_decode64(payload))
      end
      
      class BadSignatureError < Error; end
      class BadSignatureAlgorithmError < Error; end
    end
  end
end
