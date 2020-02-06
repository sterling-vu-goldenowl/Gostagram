class CreatePostPhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :post_photos do |t|
      t.integer :item_id
      t.string :photo

      t.timestamps
    end
  end
end
