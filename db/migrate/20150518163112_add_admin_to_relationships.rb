class AddAdminToRelationships < ActiveRecord::Migration
  def change
    add_column :relationships, :admin, :boolean
  end
end
