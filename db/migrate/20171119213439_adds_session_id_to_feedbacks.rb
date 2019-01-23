class AddsSessionIdToFeedbacks < ActiveRecord::Migration[5.0]
  def change
    add_column :feedbacks, :session_id, :integer
  end
end
