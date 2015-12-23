class ChangeColForFacility < ActiveRecord::Migration
  def change
    rename_column :facilities, :private, :is_private
  end
end
