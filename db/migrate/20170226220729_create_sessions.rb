class CreateSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :sessions do |t|
      t.integer :student_id
      t.integer :lesson_id
      t.integer :word_missed
      t.integer :time
      t.integer :student_mood
      t.string :recorded_by

      t.timestamps
    end
  end
end
