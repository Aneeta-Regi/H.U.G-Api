class UpdatesUserNames < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :e_first_name, :string
    add_column :users, :e_last_name, :string
    remove_column :users, :volunteer_name
    add_column :users, :specialist, :boolean
    remove_column :users, :emergency_contact_name
  end
end
