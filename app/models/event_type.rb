class EventType < ActiveRecord::Base
  belongs_to :sport
  
  def index_position
    array = []
    event_types = EventType.all
    event_types.each do |c|
      array << c.id
    end
    array.uniq.find_index(id) + 1
  end
end
