class UpdateEventsTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :events, :date
    remove_column :events, :time
    add_column :events, :start_date, :datetime
    remove_column :events, :end_date
    add_column :events, :end_date, :datetime
    rename_column :events, :title, :event_name
    rename_column :events, :link, :url
    rename_column :events, :info, :description

  end
end
