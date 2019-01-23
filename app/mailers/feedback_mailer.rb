
class FeedbackMailer < ApplicationMailer

  def feedback_email(feedback, mood)
    @feedback = feedback
    emails = User.where(persona: 'admin').collect(&:email).join(",")
    @mood = mood
    mail(to: emails, subjet: ResponseHelper::FEEDBACK_SUBJECT)

  end

  def hug_thank_you(feedback)
    @feedback = feedback
    email = @feedback.email
    mail(to: email, subjet: ResponseHelper::FEEDBACK_SUBJECT)

  end

  def hug_feedback_received(feedback)
    @feedback = feedback
    email = @feedback.email
    mail(to: email, subjet: ResponseHelper::FEEDBACK_SUBJECT)

  end
end