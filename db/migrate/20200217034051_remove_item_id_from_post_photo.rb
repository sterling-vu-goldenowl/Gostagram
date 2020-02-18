class RemoveItemIdFromPostPhoto < ActiveRecord::Migration[5.2]
  def change
    remove_column :post_photos, :item_id
  end
end
