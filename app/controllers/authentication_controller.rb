class AuthenticationController < ApplicationController
  # skip_before_action :authenticate_token!

  def create
    if (user = User.find_by(email: params[:email])).nil?
      render json: { errors: ResponseHelper::ERROR_INVALID_LOGIN }, status: :unauthorized
    elsif user.valid_password? params[:password]
      p params[:is_web]
      if user.active
        if params[:is_web]
          check_admin(user)
        else
          render json: { token: JsonWebToken.encode(sub: user.id) }
        end
      else
        render json: { errors: ResponseHelper::ERROR_REQUIREMENTS_NOT }, status: :unauthorized
      end
    else
      render json: { errors: ResponseHelper::ERROR_INVALID_LOGIN }, status: :unauthorized
    end
  end

  def check_admin(user)
    if user.persona == 'admin'
      render json: { token: JsonWebToken.encode(sub: user.id) }
    else
      render json: { errors: ResponseHelper::ERROR_NOT_ADMIN }, status: :unauthorized
    end
  end

end
