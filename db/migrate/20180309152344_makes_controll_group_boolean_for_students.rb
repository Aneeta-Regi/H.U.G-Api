class MakesControllGroupBooleanForStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :control_group, :boolean, default: false
  end
end
