class UpdatesUserWithShadowBoolean < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :completed_shadow_days, :boolean, default: false
  end
end
