class School < ApplicationRecord
  has_many :students
  has_and_belongs_to_many :users
  belongs_to :district
end
