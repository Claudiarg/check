class AuthController < ApplicationController
  before_action :authorized_request, except: :login

  #POST /auth/login
  def login
    user = User.find_by_email(params[:email])
    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      user.update(auth_token: token)
      render json: {token: token, user_id: user.id}, status: :ok
    else
      render status: :unauthorized
    end
  end

  #DELETE /auth/login
  def logout
    @current_user.update(auth_token: nil)
    render status: :ok
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
