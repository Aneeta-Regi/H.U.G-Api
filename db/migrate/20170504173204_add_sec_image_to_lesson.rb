class AddSecImageToLesson < ActiveRecord::Migration[5.0]
  def change
    add_column :lessons, :sec_image, :string
  end
end
