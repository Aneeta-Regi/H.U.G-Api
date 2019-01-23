class CreateAverages < ActiveRecord::Migration[5.0]
  def change
    create_table :averages do |t|
      t.float :acumen_one
      t.float :acumen_two
      t.integer :mood_one
      t.integer :mood_two
      t.integer :time_one
      t.integer :time_two
      t.integer :student_id

      t.timestamps
    end
  end
end
