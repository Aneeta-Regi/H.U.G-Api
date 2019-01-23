class AddsPrecentRankToScores < ActiveRecord::Migration[5.0]
  def change
    add_column :dra_records, :fall_rank, :integer
    add_column :dra_records, :winter_rank, :integer
    add_column :dra_records, :mid_year_rank_gain, :integer
    add_column :dra_records, :spring_rank, :integer
    add_column :dra_records, :end_year_rank_gain, :integer
  end
end
