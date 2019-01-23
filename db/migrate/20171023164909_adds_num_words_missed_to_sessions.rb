class AddsNumWordsMissedToSessions < ActiveRecord::Migration[5.0]
  def change
    add_column :sessions, :num_words_learned, :integer
    add_column :sessions, :comments, :string
  end
end
