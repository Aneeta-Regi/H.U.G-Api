class User < ApplicationRecord
  include ActiveModel::Dirty
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :students
  has_and_belongs_to_many :schools


end
