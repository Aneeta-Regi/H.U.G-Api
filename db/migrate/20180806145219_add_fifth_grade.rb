class AddFifthGrade < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :fifth_grade_year, :string
  end
end
