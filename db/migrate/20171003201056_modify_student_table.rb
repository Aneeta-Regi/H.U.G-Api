class ModifyStudentTable < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :graduated, :boolean, default: false
    remove_column :students, :image
    remove_column :students, :dra_score_1
    remove_column :students, :dra_score_2
    remove_column :students, :dra_score_3
    add_column :students, :vol_phone, :string
  end
end
