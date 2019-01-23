class UpdatesUserForNewFlags < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :teacher_exp, :boolean, default: false
    add_column :users, :councilor_exp, :boolean, default: false
    add_column :users, :active, :boolean, default: false
  end
end
