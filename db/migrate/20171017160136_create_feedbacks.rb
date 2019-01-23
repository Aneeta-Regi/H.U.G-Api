class CreateFeedbacks < ActiveRecord::Migration[5.0]
  def change
    create_table :feedbacks do |t|
      t.string :vol_name
      t.integer :vol_id
      t.string :email
      t.integer :mood
      t.string :comments
      t.string :resolution

      t.timestamps
    end
  end
end
