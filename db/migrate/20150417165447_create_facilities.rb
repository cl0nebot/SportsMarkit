class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.string :name
      t.string :field_type
      t.boolean :private
      t.boolean :publicly_visible
      
      # address
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :zip_ext
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps
      
      #contact
      t.string :phone_number
      t.string :email
      
      #website
      t.string :website
      
      #utility
      t.string :slug
      

      t.timestamps
    end
    add_index :facilities, :slug, :unique => true
  end
end
