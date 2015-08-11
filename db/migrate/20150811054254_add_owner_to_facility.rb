class AddOwnerToFacility < ActiveRecord::Migration
  def change
    add_column :facilities, :facility_owner_type, :string
    add_column :facilities, :facility_owner_id, :integer
  end
end
