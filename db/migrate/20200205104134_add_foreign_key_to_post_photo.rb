class AddForeignKeyToPostPhoto < ActiveRecord::Migration[5.2]
  def change
    add_reference :post_photos, :micropost, foreign_key: true
  end
end
