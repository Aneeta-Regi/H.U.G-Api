class PasswordsController < ApplicationController

  PASSWORD_RESET_SUCCESS = ResponseHelper::PASSWORD_RESET_SUCCESS

  def set_password
    # decode the token sent in from the call
    params[:token] = Devise.token_generator.digest(self, :reset_password_token, params.require(:token))
    # find the user by the token
    user = User.find_by_reset_password_token(params[:token])

    unless user == nil
      # set the password
      user.password = params[:password]

      # save the user.
      if user.save
        render json: PASSWORD_RESET_SUCCESS.to_json
      else
        render json: {errors: ResponseHelper::ERROR_NOT_FOUND}, status: :unprocessable_entity
      end
    else
      render json: {errors: ResponseHelper::ERROR_NOT_FOUND}, status: :unprocessable_entity
    end

  end

end