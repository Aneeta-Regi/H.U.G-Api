class Absence < ApplicationRecord
  belongs_to :student

  def check_number(student_id)
    absences = Absence.where(student_id: student_id)
    if absences.size > 2
      p 'send an email'
      AbsenceMailer.absence_email(student_id, absences).deliver_now
    end
  end
end
