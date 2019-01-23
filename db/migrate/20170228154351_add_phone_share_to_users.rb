class AddPhoneShareToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :share_phone, :boolean, default: true
  end
end
