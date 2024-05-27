require "jwt"

module JsonWebToken
    extend ActiveSupport::Concern
    SECRET_KEY = Rails.application.credentials.secret_key_base.to_s

    def self.encode(payload, exp: 7.days.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload,SECRET_KEY)
    end

    def self.decode(token)
      decoded = JWT.decode(token,SECRET_KEY)
      # pp "Decoded hash #{decoded}"
     hash = ActiveSupport::HashWithIndifferentAccess.new(decoded.first)
    #  pp "hash  #{hash}"
     hash
    end

end