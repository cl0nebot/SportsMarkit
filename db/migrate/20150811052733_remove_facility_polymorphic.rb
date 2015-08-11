class RemoveFacilityPolymorphic < ActiveRecord::Migration
  def change
    remove_column :facilities, :facilitatable_type
    remove_column :facilities, :facilitatable_id
  end
end
