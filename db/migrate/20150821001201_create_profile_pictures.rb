class CreateProfilePictures < ActiveRecord::Migration
  def change
    create_table :profile_pictures do |t|
      t.integer :profile_picture_owner_id
      t.string :profile_picture_owner_type
      t.string :photo, :null => false
      t.timestamps
    end
  end
end