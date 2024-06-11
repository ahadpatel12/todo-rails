class ApplicationController < ActionController::Base
  # include JsonWebToken

  before_action :authenticate_user
  rescue_from ActionController::ParameterMissing, :with => :error_param_missing
  rescue_from ActiveRecord::RecordNotFound, :with => :error_record_not_found

  def error_param_missing(exception)
    render json: {error: exception.message}, status: 400
  end

  def error_record_not_found(exception)
    render json: {error: exception.message}, status: 404
  end


  private
  def authenticate_user
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    pp "header #{header}"
    begin
      decoded = JsonWebToken.decode(header)
      pp "Decoded #{decoded[:user]}"
      @current_user = User.find(decoded[:user][:id])
      pp "decode user #{@current_user}"
    rescue JWT::DecodeError, ActionController::InvalidAuthenticityToken
      render json: {error: "Invalid Authentication token"}, status: 401
    end
  end
end
