class AddDateToSession < ActiveRecord::Migration[5.0]
  def change
    add_column :sessions, :date, :string
  end
end
