class AddVolNameAndEmailToStudent < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :vol_name, :string
    add_column :students, :vol_email, :string
  end
end
