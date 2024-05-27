class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  # skip_before_action :authenticate_user, only: [:register, :login]


  # def create
  #   user = User.new(
  #     email: user_params[:email],
  #     password: user_params[:password]
  #   )
  #   user.save
  # end

  # def register
  #   begin
  #     user_params.require([:email, :password])
  #     user = User.find_by_email(user_params[:email])
  #     raise "User Already registered" if user

  #     user = User.new(
  #       email: user_params[:email],
  #       password: user_params[:password]
  #     )
  #     if user.save
  #       render json: user, status: 200
  #     else
  #       raise "User register failed"
  #     end
  #   rescue Exception => e
  #     render json: {message: e}, status: 400
  #   end
  # end

  # def login
  #   begin
  #     user_params.require([:email, :password])
  #     # user_params.require(:password)
  #     user = User.find_by_email(user_params[:email])
  #     raise "User not found" unless user
  #     raise "Password does not match" unless user[:password] == user_params[:password]
  #     render json: user, status: 200
  #   rescue ActionController::ParameterMissing => e
  #     render json: {message: e.message}, status: 404
  #   rescue ActiveRecord::RecordNotFound => e
  #     render json: {message: e.message}, status: 400
  #   end
  # end

  def list
    users = User.all
    render json: users, status: 200
  end

  def update
    id = @current_user[:id]
    begin
    user_params.require([:email, :password])
    user = User.find(id)
    pp "id #{id}"
    pp "user #{user.as_json}"
    # raise "User not found"
    user.update(email: user_params[:email], password: user_params[:password])
    # user.save
    render json: {data: user, message: "User updated Successfully"}, status: 200
    rescue ActionController::ParameterMissing => e
      render json: {message: e.message}, status: 404
    rescue ActiveRecord::RecordNotFound => e
      render json: {message: e.message}, status: 404
    end
  end

  def destroy
    id = params[:id]
    begin
    User.destroy(id)
    render json: { message: "User with Id-#{id} deleted successfully"}
    rescue ActiveRecord::RecordNotFound => e
      render json: {message: e.message}, status: 404
    end
  end


  private
    def user_params
      params.permit([
        :email,
        :password
      ])
    end
    
end
