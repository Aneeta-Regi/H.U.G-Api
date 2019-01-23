class AddsMemsToLui < ActiveRecord::Migration[5.0]
  def change
    add_column :lastuserimports, :member, :string, array: true, default: []
  end
end
