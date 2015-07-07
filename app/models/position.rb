class Position < ActiveRecord::Base
  belongs_to :sport
  has_many :positionings, :dependent => :destroy
  
  def index_position
    array = []
    positions = Position.all
    positions.each do |p|
      array << p.id
    end
    array.uniq.find_index(id) + 1
  end
  
end
