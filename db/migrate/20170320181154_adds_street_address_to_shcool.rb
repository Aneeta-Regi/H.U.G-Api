class AddsStreetAddressToShcool < ActiveRecord::Migration[5.0]
  def change
    add_column :schools, :address, :string
  end
end
