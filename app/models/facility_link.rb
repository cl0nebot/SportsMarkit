class FacilityLink < ActiveRecord::Base
  belongs_to :facilitatable, polymorphic: true
  belongs_to :facility
end
