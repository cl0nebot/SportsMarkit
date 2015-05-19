class CreatePhotosTable < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :photo_owner_id
      t.string :photo_owner_type
      t.string :image
      t.boolean :main, default: false
      t.timestamp
    end
    add_index :photos, :photo_owner_id
    add_index :photos, :photo_owner_type
  end
end
