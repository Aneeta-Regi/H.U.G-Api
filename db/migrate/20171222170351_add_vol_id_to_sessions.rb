class AddVolIdToSessions < ActiveRecord::Migration[5.0]
  def change
    add_column :sessions, :vol_id, :integer
  end
end
