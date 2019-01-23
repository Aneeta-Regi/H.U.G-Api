class CreateDraRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :dra_records do |t|
      t.string :grade
      t.string :school_year
      t.integer :dra_1
      t.integer :dra_2
      t.integer :dra_3
      t.integer :student_id

      t.timestamps
    end
  end
end
