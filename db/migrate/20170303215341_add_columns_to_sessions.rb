class AddColumnsToSessions < ActiveRecord::Migration[5.0]
  def change
    add_column :sessions, :acumen, :float
    add_column :sessions, :first_attempt, :boolean, default: true
    add_column :sessions, :second_attempt, :boolean, default: false
  end
end
