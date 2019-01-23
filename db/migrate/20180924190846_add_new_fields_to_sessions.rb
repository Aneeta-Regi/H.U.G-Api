class AddNewFieldsToSessions < ActiveRecord::Migration[5.0]
  def change
    add_column :sessions, :school_year,  :string
    add_column :sessions, :student_name, :string
    add_column :sessions, :grade_level,  :string
    add_column :sessions, :school_name,  :string
    add_column :sessions, :school_id,    :integer
  end
end
