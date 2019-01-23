class Feedback < ApplicationRecord
  belongs_to :session
  has_many :resolutions

  def set_mood
    case self.mood
      when 1..2
        mood = 'negative.png'
      when 3
        mood = 'blah.png'
      when 4..5
        mood = 'positive.png'
    end
     mood
  end


end
