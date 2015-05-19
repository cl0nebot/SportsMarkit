class SetRelationshipAdminToFalseDefau < ActiveRecord::Migration
  def change
    change_column :relationships, :admin, :boolean, default: false
    execute('update relationships set admin=false where 1')
  end
end
