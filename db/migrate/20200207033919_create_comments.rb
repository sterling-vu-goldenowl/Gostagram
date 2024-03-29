class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.text :body
      t.references :micropost, null: false, foreign_key: true

      t.timestamps
    end
  end
end
