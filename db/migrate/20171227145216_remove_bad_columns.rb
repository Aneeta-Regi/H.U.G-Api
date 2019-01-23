class RemoveBadColumns < ActiveRecord::Migration[5.0]
  def change
    remove_column :lastuserimports, :members
    remove_column :lastuserimports, :people
    remove_column :lastuserimports, :member
  end
end
