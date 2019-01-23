class AddLessonIdentifierAndGradeToLessons < ActiveRecord::Migration[5.0]
  def change
    add_column :lessons, :grade_level, :integer
    add_column :lessons, :lesson_identifier, :string

  end
end
