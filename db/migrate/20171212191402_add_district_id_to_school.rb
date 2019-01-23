class AddDistrictIdToSchool < ActiveRecord::Migration[5.0]
  def change
    add_column :schools, :district_id, :integer
  end
end
