class DropPictureFromMicropost < ActiveRecord::Migration[5.2]
  def change
    remove_column :microposts, :picture
  end
end
