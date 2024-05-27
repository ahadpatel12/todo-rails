module Exceptions
  class AuthenticationException < StandardError; end
  class EmailExistsException < AuthenticationException; end
  class UserNotFoundException < AuthenticationException; end
  class InvalidPasswordException < AuthenticationException; end

end