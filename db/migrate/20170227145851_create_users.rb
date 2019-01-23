class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :volunteer_name
      t.string :commitment_level
      t.string :phone
      t.string :second_phone
      t.string :persona
      t.boolean :background_check
      t.boolean :code_of_ethics
      t.string :emergency_contact_name
      t.string :emergency_contact_number
      t.string :image
      t.string :notes
      t.string :password
      t.integer :school_id, array: true, default: []

      t.timestamps
    end
  end
end
