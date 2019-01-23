class AddsLexileNumberScoresToDras < ActiveRecord::Migration[5.0]
  def change
    add_column :dra_records, :fall_lexile_one, :integer
    add_column :dra_records, :winter_lexile_one, :integer
    add_column :dra_records, :spring_lexile_one, :integer
    add_column :dra_records, :fall_lexile_two, :integer
    add_column :dra_records, :winter_lexile_two, :integer
    add_column :dra_records, :spring_lexile_two, :integer
  end
end
