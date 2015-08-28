class MakeChangesToLeague < ActiveRecord::Migration
  def change
    rename_column :leagues, :mobile_phone_number, :phone_number
    remove_column :leagues, :foursquare
  end
end
