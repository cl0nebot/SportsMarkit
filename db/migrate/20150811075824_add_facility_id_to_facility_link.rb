class AddFacilityIdToFacilityLink < ActiveRecord::Migration
  def change
    add_column :facility_links, :facility_id, :integer
  end
end
