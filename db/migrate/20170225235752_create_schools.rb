class CreateSchools < ActiveRecord::Migration[5.0]
  def change
    create_table :schools do |t|
      t.string :school_name
      t.string :school_phone
      t.string :school_city
      t.string :school_state
      t.integer :school_zip
      t.string :school_district
      t.string :principal_name
      t.string :vice_principal_name
      t.string :clarity_person_name
      t.string :clarity_person_phone
      t.string :clarity_person_second_phone
      t.string :clarity_person_email
      t.string :notes

      t.timestamps
    end
  end
end
