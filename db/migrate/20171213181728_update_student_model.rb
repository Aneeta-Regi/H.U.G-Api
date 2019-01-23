class UpdateStudentModel < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :second_grade_year, :string
    add_column :students, :third_grade_year, :string
    add_column :students, :other_program_notes, :string
    add_column :students, :num_other_programs, :integer
  end
end
