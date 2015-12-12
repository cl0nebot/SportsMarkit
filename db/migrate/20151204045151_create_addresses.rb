class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :addressable_id
      t.string  :addressable_type
      t.string  :street_1
      t.string  :street_2
      t.string  :city
      t.string  :county
      t.string  :state
      t.string  :country
      t.string  :postcode
      t.string  :suite
      t.boolean :default
      t.string  :nickname
      t.string  :latitude
      t.string  :longitude
      t.boolean :gmaps 
      t.timestamps
    end
  end
end
