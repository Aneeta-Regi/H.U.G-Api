class CreateLastuserimports < ActiveRecord::Migration[5.0]
  def change
    create_table :lastuserimports do |t|
      t.integer :group_id
      t.integer :member_id

      t.timestamps
    end
  end
end
