class AddSettingsToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :settings, :text
  end
end
