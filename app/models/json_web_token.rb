require 'base64'
require 'json'
require 'openssl'

class JsonWebToken

    ALGO = 'RS256'
    HEADER = { alg: "HS256", typ: "JWT" }
    KEY = "NdRgUkXp2s5v8y/B?E(G+KbPeShVmYq3"


  class << self

    def encode(payload, exp = 2.hours.from_now)
      payload[:expired_at] = exp.to_i

      jsonStringHeader = JSON.dump(HEADER)
      jsonStringPayload = JSON.dump(payload)
      base64HeaderEncoded = Base64.encode64(jsonStringHeader)
      base64PayloadEncoded = Base64.encode64(jsonStringPayload)

      data = base64HeaderEncoded + "." + base64PayloadEncoded
      signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), KEY, data)

      data + "." + signature
    end

    def validate_token(token)
      
      parts = decode(token)
      
      header = parts[:header]
      payload = parts[:payload]
      signature = parts[:signature]

      resul = { message: "", status: 401 }
      if signature_is_valid(signature, payload, header)
        if verify_identity(payload)
          if is_expired(payload)
            resul[:message]="Token ya ha expirado"
          else
            resul[:status]=200
          end

        else
          resul[:message]="Token Invalido"  
        end
        
      else
        resul[:message]="Token Invalido"
      end
      
      resul

    end

    private

    def verify_identity(payload)
      payload_hash = JSON.load(payload)
      identity_user = User.where("uuid = ? AND mail = ?", payload_hash['uuid'], payload_hash['mail'] )
      identity_user.present?
    end

    private

    def signature_is_valid(signature, payload, header)

      base64HeaderEncoded = Base64.encode64(header)
      base64PayloadEncoded = Base64.encode64(payload)

      data = base64HeaderEncoded + "." + base64PayloadEncoded
      signature_new = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), KEY, data)

      signature === signature_new

    end

    private

    def decode(token)
      jwtTokenParts = token.split('.')

      base64HeaderEncoded = jwtTokenParts[0]
      base64PayloadEncoded = jwtTokenParts[1]
      signature = jwtTokenParts[2]


      jsonStringHeader = Base64.decode64(base64HeaderEncoded)
      jsonStringPayload = Base64.decode64(base64PayloadEncoded)

      token_parts = { header: jsonStringHeader, payload: jsonStringPayload, signature: signature }
      
    end

    private

    def is_expired(jsonStringPayload)
        payload = JSON.load(jsonStringPayload)
        expired_time = payload["expired_at"]
        current_time = Time.now.to_i

        current_time > expired_time
        
    end

  end

end