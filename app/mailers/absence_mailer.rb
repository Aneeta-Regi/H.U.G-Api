class AbsenceMailer < ApplicationMailer

  def absence_email(student_id, absences)
    @absences = absences
    @student = Student.find(student_id)
    emails = User.where(persona: 'admin').collect(&:email).join(",")
    mail(to: emails, subjet: ResponseHelper::FEEDBACK_SUBJECT)
  end
end