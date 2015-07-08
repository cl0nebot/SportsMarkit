class FacilityType < ActiveRecord::Base
  
  def index_position
    array = []
    facility_types = FacilityType.all
    facility_types.each do |c|
      array << c.id
    end
    array.uniq.find_index(id) + 1
  end
  
end
