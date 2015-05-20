class RemoveSchoolIdFromRelationship < ActiveRecord::Migration
  def change
    remove_column :relationships, :school_id
  end
end
