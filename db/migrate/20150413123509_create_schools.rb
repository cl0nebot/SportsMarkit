class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      #description
      t.string :name
      t.string :classification #high school, middle school, college
      t.string :abbreviation
      
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
      t.string :stripe_customer_id

      t.timestamps
    end
    add_index :schools, :slug, :unique => true
  end
end
