class AddStudentMatchingLevelForTutor < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :student_matching_level, :integer
  end
end
