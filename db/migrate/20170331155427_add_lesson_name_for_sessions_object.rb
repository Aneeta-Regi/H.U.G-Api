class AddLessonNameForSessionsObject < ActiveRecord::Migration[5.0]
  def change
    add_column :sessions, :lesson_identifier, :string
  end
end
