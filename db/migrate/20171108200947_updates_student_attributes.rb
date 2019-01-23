class UpdatesStudentAttributes < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :why_inactive, :string
    add_column :students, :s_last_name, :string
  end
end
