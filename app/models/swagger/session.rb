class Swagger::Session < Swagger::Model
  swagger_schema :session do
    property :lesson_name do
      key :type, :string
    end
    property :summary do
      key :type, :string
    end
    property :lesson_identifier do
      key :type, :string
    end
    property :recorded_by do
      key :type, :string
    end
    property :comments do
      key :type, :string
    end
    property :first_attempt do
      key :type, :boolean
    end
    property :second_attempt do
      key :type, :boolean
    end
    property :date do
      key :type, :string
      key :format, :"date-time"
    end
    property :time do
      key :type, :integer
      key :format, :int64
    end
    property :num_words_learned do
      key :type, :integer
      key :format, :int64
    end
    property :student_mood do
      key :type, :integer
      key :format, :int64
    end
    property :lesson_id do
      key :type, :integer
      key :format, :int64
    end
    property :student_id do
      key :type, :integer
      key :format, :int64
      key :description, 'you will send in this but can’t update it'
    end
    property :word_missed do
      key :type, :integer
      key :format, :int64
    end
    property :vol_id do
      key :type, :integer
      key :format, :int64
    end
    property :words_missed_one do
      key :type, :integer
      key :format, :int64
    end
    property :words_missed_two do
      key :type, :integer
      key :format, :int64
    end
    property :mood_one do
      key :type, :integer
      key :format, :int64
    end
    property :mood_two do
      key :type, :integer
      key :format, :int64
    end


    property :acumen do
      key :type, :number
      key :format, :float
    end
  end
end
