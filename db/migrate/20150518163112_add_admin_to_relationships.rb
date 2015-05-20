class AddAdminToRelationships < ActiveRecord::Migration
  def change
    add_column :relationships, :admin, :boolean
    add_column :relationships, :school_id, :integer
    add_column :users, :temporary_school_ids, :integer
  end
end
