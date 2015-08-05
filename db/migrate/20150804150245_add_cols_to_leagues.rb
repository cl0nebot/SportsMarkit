class AddColsToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :email, :string
    add_column :leagues, :website, :string
    add_column :leagues, :mobile_phone_number, :string
    add_column :leagues, :address_1, :string
    add_column :leagues, :address_2, :string
    add_column :leagues, :city, :string
    add_column :leagues, :zip, :integer
    add_column :leagues, :zip_ext, :integer
    add_column :leagues, :latitude, :float, limit: 24
    add_column :leagues, :longitude, :float, limit: 24 
  end
end
