class AuthenticationService
    def self.authenticate_user_with_password!(email, password)
      user = User.find_by(email: email)&.authenticate(password)
      raise AuthenticationError if user.nil?
  
      user
    end
  
    def self.authenticate_user_with_token!(token)
      rsa_private = OpenSSL::PKey::RSA.new(File.read(Rails.root.join('auth/service.key')))
      begin
        decoded_token = JWT.decode(token, rsa_private, true, { algorithm: 'RS256' })
      rescue JWT::DecodeError, JWT::ExpiredSignature, JWT::VerificationError
        raise AuthenticationError
      end
      user_id = decoded_token.first["sub"]
      user = User.find(user_id)
      raise AuthenticationError if user.nil?
  
      user
    end
  end