class UpdatesLesson < ActiveRecord::Migration[5.0]
  def change
    add_column :lessons, :active, :boolean, default: true
  end
end
