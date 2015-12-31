class RmUnusedAddressFields < ActiveRecord::Migration
  def change
    remove_column :teams, :address_1
    remove_column :teams, :address_2
    remove_column :teams, :city
    remove_column :teams, :state
    remove_column :teams, :zip
    remove_column :teams, :zip_ext
    remove_column :teams, :latitude
    remove_column :teams, :longitude
    remove_column :teams, :gmaps
    
    remove_column :schools, :address_1
    remove_column :schools, :address_2
    remove_column :schools, :city
    remove_column :schools, :state
    remove_column :schools, :zip
    remove_column :schools, :zip_ext
    remove_column :schools, :latitude
    remove_column :schools, :longitude
    remove_column :schools, :gmaps
    
    remove_column :facilities, :address_1
    remove_column :facilities, :address_2
    remove_column :facilities, :city
    remove_column :facilities, :state
    remove_column :facilities, :zip
    remove_column :facilities, :zip_ext
    remove_column :facilities, :latitude
    remove_column :facilities, :longitude
    remove_column :facilities, :gmaps
    
    remove_column :leagues, :address_1
    remove_column :leagues, :address_2
    remove_column :leagues, :city
    remove_column :leagues, :state
    remove_column :leagues, :zip
    remove_column :leagues, :zip_ext
    remove_column :leagues, :latitude
    remove_column :leagues, :longitude
    remove_column :leagues, :gmaps
    
    
  end
end
