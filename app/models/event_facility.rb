class EventFacility < ActiveRecord::Base
  belongs_to :event
  belongs_to :facility
  
  
  def proper_facility_name
    if event.facility.school.present?
      "#{event.facility.school.name} #{facility.name}"
    else
      "#{facility.name}"
    end
  end
  
  def proper_facility_name_and_location
    if event.facility.school.present?
      "#{event.facility.school.name} #{facility.name}, #{event.facility.city_and_state}"
    else
      "#{facility.name} #{event.facility.city_and_state}"
    end
    
  end
  
end
