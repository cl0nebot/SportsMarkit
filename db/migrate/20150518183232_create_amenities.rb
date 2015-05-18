class CreateAmenities < ActiveRecord::Migration
  def change
    create_table :amenities do |t|
      t.string :amenity
      t.timestamps
    end
  end
end
