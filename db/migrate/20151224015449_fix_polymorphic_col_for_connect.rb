class FixPolymorphicColForConnect < ActiveRecord::Migration
  def change
    rename_column :connects, :owner_id, :ownerable_id
    rename_column :connects, :owner_type, :ownerable_type
  end
end
