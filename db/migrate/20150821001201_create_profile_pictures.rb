class CreateProfilePictures < ActiveRecord::Migration
  def change
    create_table :profile_pictures do |t|
      t.integer :profile_picture_owner_id, polymorphic: true
      t.string :photo, :null => false
      t.timestamps
    end
  end
end