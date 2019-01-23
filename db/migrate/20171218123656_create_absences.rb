class CreateAbsences < ActiveRecord::Migration[5.0]
  def change
    create_table :absences do |t|
      t.integer :student_id
      t.datetime :date
      t.string :vol_name
      t.integer :lesson_id
      t.string :lesson_name
      t.string :lesson_identifier

      t.timestamps
    end
  end
end
