class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.integer :school_id
      t.string :school_name
      t.integer :user_id
      t.integer :dra_score_1
      t.integer :dra_score_2
      t.integer :dra_score_3
      t.string :notes
      t.string :image

      t.timestamps
    end
  end
end
