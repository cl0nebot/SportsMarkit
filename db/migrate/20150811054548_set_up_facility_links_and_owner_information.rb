class SetUpFacilityLinksAndOwnerInformation < ActiveRecord::Migration
  def change
    #facility_owner_information
    Facility.all.each do |facility|
      if facility.school_id.present?
        facility.update_attributes(facility_owner_type: "School", facility_owner_id: facility.school_id)
      end
    end
    
    #set up team links
    TeamFacility.all.each do |facility|
      FacilityLink.create(facilitatable_type: "Team", facilitatable_id: facility.team_id)
    end
    
    
  end
end
