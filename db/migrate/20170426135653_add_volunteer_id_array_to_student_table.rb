class AddVolunteerIdArrayToStudentTable < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :vol_ids, :integer, array: true, default: []
  end
end
