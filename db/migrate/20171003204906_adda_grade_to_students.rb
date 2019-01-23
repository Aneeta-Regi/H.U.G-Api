class AddaGradeToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :grade, :string
  end
end
