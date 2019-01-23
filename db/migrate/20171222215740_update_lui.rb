class UpdateLui < ActiveRecord::Migration[5.0]
  def change
    add_column :lastuserimports, :people, :text, array: true, default: []
  end
end
