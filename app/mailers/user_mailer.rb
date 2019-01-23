
class UserMailer < ApplicationMailer


  def welcome_email(user)
    @user = user
    @url = ResponseHelper::PASSWORD_RESET_URL
    mail(to: @user.email, subjet: ResponseHelper::WELCOME_SUBJECT_LINE)
  end

  def password_reset_email(user)
    @user = user
    @url = ResponseHelper::PASSWORD_RESET_URL
    mail(to: @user.email, subjet: ResponseHelper::RESET_PASSWORD_LINE)
  end
end
