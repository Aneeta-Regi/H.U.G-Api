class UpdatesAbsences < ActiveRecord::Migration[5.0]
  def change
    rename_column :absences, :vol_name, :recorded_by
    add_column :absences, :vol_id, :integer
  end
end
