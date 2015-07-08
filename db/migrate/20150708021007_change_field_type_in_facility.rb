class ChangeFieldTypeInFacility < ActiveRecord::Migration
  def change
    rename_column :facilities, :field_type, :facility_type
  end
end
