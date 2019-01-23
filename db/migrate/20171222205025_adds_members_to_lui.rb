class AddsMembersToLui < ActiveRecord::Migration[5.0]
  def change
    add_column :lastuserimports, :members, :string, array: true
  end
end
