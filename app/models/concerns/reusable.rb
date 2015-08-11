module Reusable
  extend ActiveSupport::Concern
  
  def owned_facilities
    Facility.where(facility_owner_id: id, facility_owner_type: self.class.to_s)
  end
  
  def used_facilities
    facility_ids = facility_links.pluck(:facility_id)
    Facility.where(id: facility_ids)
  end
  
end