class ChangeStudentLastNameToClassName < ActiveRecord::Migration[5.0]
  def change
    rename_column :students, :last_name, :class_name
  end
end
