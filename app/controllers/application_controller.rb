class ApplicationController < ActionController::Base
  # include JsonWebToken
  
  before_action :authenticate_user

  private
  def authenticate_user
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    pp "header #{header}"
    begin
      decoded = JsonWebToken.decode(header)
      pp "Decoded #{decoded}" 
      @current_user = User.find(decoded[:user][:id])
    rescue JWT::DecodeError
      render json: {error: "Invalid Authentication token"}, status: 401
    end
  end

end
