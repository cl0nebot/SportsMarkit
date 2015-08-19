class AddGmapsToTable < ActiveRecord::Migration
  def change
    add_column :leagues, :gmaps, :boolean
  end
end
