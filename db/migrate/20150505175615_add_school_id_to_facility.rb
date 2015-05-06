class AddSchoolIdToFacility < ActiveRecord::Migration
  def change
    add_column :facilities, :school_id, :integer
  end
end
