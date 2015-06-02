class AddAddressToTeam < ActiveRecord::Migration
  def change
    #description
    add_column :teams, :classification, :string #recreational, semi pro, casual etc
    add_column :teams, :abbreviation, :string
    
    # address
    add_column :teams, :address_1, :string
    add_column :teams, :address_2, :string
    add_column :teams, :city, :string
    add_column :teams, :state, :string
    add_column :teams, :zip, :string
    add_column :teams, :zip_ext, :string
    add_column :teams, :latitude, :float
    add_column :teams, :longitude, :float
    add_column :teams, :gmaps, :boolean
    
    #contact
    add_column :teams, :phone_number, :string
    add_column :teams, :email, :string
    
    #website
    add_column :teams, :website, :string
    
    #utility
    add_column :teams, :stripe_customer_id, :string
    
  end
end
