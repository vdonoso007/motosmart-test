require 'securerandom'

class User < ApplicationRecord

    validates :name, presence: true
    validates :mail, presence: true, format: { with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/ }
    validates :password, presence: true

    has_many :rankings

    def get_uuid
        uuid_generated = SecureRandom.uuid
        uuid_generated
    end

    def create_token(name, mail, uuid)
        hash = { name: "#{name}", mail: "#{mail}", uuid: "#{uuid}" }
        token = JsonWebToken::encode(hash)
        token = token.gsub("\n",'')
        token
    end

end
