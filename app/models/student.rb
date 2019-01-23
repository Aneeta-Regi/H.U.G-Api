class Student < ApplicationRecord
  has_one :average
  has_many :sessions
  has_many :dra_records
  has_many :absences

def advance
  if grade == '2nd'
    # set the new grade level
    self.grade = '3rd'
    # we need to know what the last school year was so we can set a new 3rd grade year
    school_year = self.second_grade_year
    first = school_year.partition('/').first
    second = school_year.partition('/').last
    first_year = first.to_i + 1
    second_year = second.to_i + 1
    new_year = first_year.to_s + '/' + second_year.to_s
    self.third_grade_year = new_year
  elsif grade == '3rd'
    self.active = false
    self.why_inactive = 'graduated'
  end
  self.save
end

def revert
  if active == false
    self.active = true
    self.why_inactive = ' '
  else
    self.grade = '2nd'
    self.third_grade_year = ' '
  end
  self.save
end

def add_note(new_note)
  self.notes = self.notes + new_note
  self.save
end

def assign_tutor(volunteer)
  self.vol_phone = volunteer.phone
  self.vol_name = volunteer.first_name + ' ' + volunteer.last_name
  self.vol_email = volunteer.email
  self.save
end

end