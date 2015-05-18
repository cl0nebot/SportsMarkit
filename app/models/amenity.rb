class Amenity < ActiveRecord::Base
  
  def index_position
    array = []
    amenities = Amenity.all
    amenities.each do |a|
      array << a.id
    end
    array.uniq.find_index(id) + 1
  end
  
end
