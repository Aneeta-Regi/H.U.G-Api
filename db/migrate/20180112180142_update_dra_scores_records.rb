class UpdateDraScoresRecords < ActiveRecord::Migration[5.0]
  def change
    rename_column :dra_records, :dra_1, :fall_dra
    rename_column :dra_records, :dra_2, :winter_dra
    add_column :dra_records, :mid_year_dra_gain, :integer
    rename_column :dra_records, :dra_3, :spring_dra
    add_column :dra_records, :end_of_year_dra_gain, :integer

    add_column :dra_records, :fall_rit, :integer
    add_column :dra_records, :winter_rit, :integer
    add_column :dra_records, :mid_year_rit_gain, :integer
    add_column :dra_records, :spring_rit, :integer
    add_column :dra_records, :end_of_year_rit_gain, :integer
  end
end
