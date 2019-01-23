require 'ResponseHelper'
require 'UserHelper'
require 'roo'
class ApplicationController < ActionController::Base

  include UserHelper
  # this sets the payload to the decoded version of the auth_token from below and allows the system to find the user
  # via the sub tag which is just the user_id and assigns that to current_user.

  def authenticate_token!
    payload = JsonWebToken.decode(auth_token)
    @current_user = User.find(payload['sub'])
  rescue JWT::DecodeError
    render json: { errors: ResponseHelper::BAD_TOKEN }, status: :unauthorized
  end

  # this pulls the last part of the token passed in the Authorization header and assigns it to auth_token
  def auth_token
    @auth_token ||= request.headers.fetch('Authorization', '').split(' ').last
  end

  # Rescue when find(id) fails
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  rescue_from ActiveRecord::RecordNotUnique, :with => :record_not_unique

  def record_not_found
    render json: { errors: ResponseHelper::ERROR_NOT_FOUND }, status: :unprocessable_entity
  end

  def record_not_unique
    render json: { errors: ResponseHelper::ERROR_USER_NOT_UNIQUE }, status: :unprocessable_entity
  end

  def check_permission
    render json: { errors: ResponseHelper::ERROR_NOT_SPECIAL }, status: :unauthorized unless @current_user.specialist || @current_user.persona == 'admin'
  end

  def set_school_year(date_object)
    date_obj = date_object.partition('T').first
    year = date_obj.partition('-').first.to_i
    step1 = date_obj.partition('-').last
    month = step1.partition('-').first.to_i

    if month > 6
      syB = year + 1
      syA = year
    else
      syB = year
      syA = year - 1
    end
    @set_school_year = syA.to_s + '/' + syB.to_s
  end

end
