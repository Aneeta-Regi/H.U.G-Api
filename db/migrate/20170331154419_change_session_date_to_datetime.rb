class ChangeSessionDateToDatetime < ActiveRecord::Migration[5.0]
  def change
    remove_column :sessions, :date
    add_column :sessions, :date, :datetime
  end
end
