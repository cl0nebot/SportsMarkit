class CreateSportPhotos < ActiveRecord::Migration
  def change
    create_table :sport_photos do |t|
      t.belongs_to :sport, :null => false
      t.string :photo
      t.string :icon 
      t.timestamps
    end
    add_index :sport_photos, :sport_id
  end
end