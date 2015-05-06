class RemoveSpaIconFromSpaPhotoModel < ActiveRecord::Migration
  def change
    remove_column :sport_photos, :icon
  end
end
