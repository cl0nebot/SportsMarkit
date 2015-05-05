class AddSchoolIdToFacility < ActiveRecord::Migration
  def change
    add_column :facilities, :school_id, :integer
    add_column :facilities, :team_id, :integer
  end
end
