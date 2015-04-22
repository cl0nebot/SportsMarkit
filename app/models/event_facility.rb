class EventFacility < ActiveRecord::Base
  belongs_to :event
  belongs_to :facility
  
  
end
