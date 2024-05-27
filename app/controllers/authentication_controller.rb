class AuthenticationController < ApplicationController
  include JsonWebToken
  skip_before_action :authenticate_user, :verify_authenticity_token

  def login
    begin
    auth_params.require([:email, :password])
    user = User.find_by_email(params[:email].downcase)
    raise Exceptions::UserNotFoundException unless user
    raise Exceptions::InvalidPasswordException unless user[:password] == auth_params[:password]

      token = JsonWebToken.encode({user:user})
      time = Time.now() + 7.days.to_i
      render json: {
        token: token,
        exp: time.strftime("%d-%m-%Y %H:%M"),
        user: user,
        message: "Login Success"
      }, status: :ok
    rescue Exceptions::UserNotFoundException
      render json: {error: "User Not found"}, status: 400
    rescue Exceptions::InvalidPasswordException
      render json: {error: "Invalid Password"}, status: 400
    end
  end

  def register
    begin
    auth_params.require([:email, :password])
    user = User.find_by_email(auth_params[:email].downcase)
    raise Exceptions::EmailExistsException unless user
    token = JsonWebToken.encode({user:user})
    user = User.new(
      email: auth_params[:email],
      password: auth_params[:password]
    )
    user.save
    time = Time.now() + 7.days.to_i
    render json: {
      token: token,
      exp: time.strftime("%d-%m-%Y %H:%M"),
      user: user,
      message: "User Created Successfully"
    }, status: :created

  rescue Exceptions::EmailExistsException
    render json: {error: "Email already exists", user_name: user[:email]}, status: 400
  end


    # begin
      # auth_params.require([:email, :password])

      # user = User.find_by_email(user_params[:email])
      # raise "User Already registered" if user
      # user = User.new(
      #   email: user_params[:email],
      #   password: user_params[:password]
      # )
      # if user.save
      #   render json: user, status: 200
      # else
      #   raise "User register failed"
      # end
    # rescue Exception => e
    #   render json: {message: e}, status: 400
    # end
  end

    def auth_params
      params.permit([
        :email,
        :password
      ])
    end

end
