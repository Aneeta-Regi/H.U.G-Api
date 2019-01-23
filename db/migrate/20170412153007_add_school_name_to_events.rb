class AddSchoolNameToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :school_name, :string
  end
end
