class AddsMemberarrayToLui < ActiveRecord::Migration[5.0]
  def change
    add_column :lastuserimports, :memberarray, :string, array: true, default: []
  end
end
