class CreateResolutions < ActiveRecord::Migration[5.0]
  def change
    create_table :resolutions do |t|
      t.string :user_name
      t.string :comment
      t.integer :feedback_id

      t.timestamps
    end
  end
end
