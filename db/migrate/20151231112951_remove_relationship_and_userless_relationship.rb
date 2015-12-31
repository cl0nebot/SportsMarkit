class RemoveRelationshipAndUserlessRelationship < ActiveRecord::Migration
  def change
    drop_table :relationships
    drop_table :userless_relationships
  end
end
