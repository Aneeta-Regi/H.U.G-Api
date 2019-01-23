class CreateLessons < ActiveRecord::Migration[5.0]
  def change
    create_table :lessons do |t|
      t.string :lesson_name
      t.string :summary
      t.integer :total_word
      t.string :image

      t.timestamps
    end
  end
end
