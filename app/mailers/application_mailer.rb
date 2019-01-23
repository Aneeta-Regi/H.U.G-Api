require 'ResponseHelper'
class ApplicationMailer < ActionMailer::Base
  add_template_helper(EmailHelper)
  default from: ResponseHelper::DEFAULT_FROM_ADDRESS
  layout 'mailer'
end
