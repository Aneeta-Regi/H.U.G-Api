class AddKeysToStudent < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :zip_code, :integer
    add_column :students, :clarity_person_name, :string
    add_column :students, :clarity_email, :string
    add_column :students, :clarity_phone, :string
    add_column :students, :clarity_alt_phone, :string
  end
end
