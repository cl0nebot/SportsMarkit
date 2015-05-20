class SetRelationshipAdminToFalseDefau < ActiveRecord::Migration
  def change
    change_column :relationships, :admin, :boolean, default: false
  end
end
