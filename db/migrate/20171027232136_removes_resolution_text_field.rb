class RemovesResolutionTextField < ActiveRecord::Migration[5.0]
  def change
    remove_column :feedbacks, :resolution
  end
end
