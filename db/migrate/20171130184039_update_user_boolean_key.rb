class UpdateUserBooleanKey < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :councilor_exp, :counselor_exp
  end
end
