class AddEndDateToEvnets < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :end_date, :string
  end
end
