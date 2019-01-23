class AddLabelToEventsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :label, :string
  end
end
