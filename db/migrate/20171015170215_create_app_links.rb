class CreateAppLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :app_links do |t|
      t.string :title
      t.string :description
      t.string :link
      t.integer :sort_order
      t.string :icon

      t.timestamps
    end
  end
end
