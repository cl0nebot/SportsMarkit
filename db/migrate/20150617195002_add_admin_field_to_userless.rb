class AddAdminFieldToUserless < ActiveRecord::Migration
  def change
    add_column :userless_relationships, :admin, :boolean
  end
end
