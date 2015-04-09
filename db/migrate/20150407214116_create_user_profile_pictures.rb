class CreateUserProfilePictures < ActiveRecord::Migration
  def change
    create_table :user_profile_pictures do |t|
      t.belongs_to :user, :null => false
      t.string :photo, :null => false
      t.timestamps
    end
    add_index :user_profile_pictures, :user_id
    add_index :user_profile_pictures, :photo 
  end
end