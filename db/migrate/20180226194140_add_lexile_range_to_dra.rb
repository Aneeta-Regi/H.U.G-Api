class AddLexileRangeToDra < ActiveRecord::Migration[5.0]
  def change
    add_column :dra_records, :fall_lexile, :string
    add_column :dra_records, :winter_lexile, :string
    add_column :dra_records, :spring_lexile, :string
  end
end
