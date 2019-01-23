class CreateDistricts < ActiveRecord::Migration[5.0]
  def change
    create_table :districts do |t|
      t.integer :district_num
      t.string :name
      t.string :state

      t.timestamps
    end
  end
end
