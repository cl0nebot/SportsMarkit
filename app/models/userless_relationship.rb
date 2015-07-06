class UserlessRelationship < ActiveRecord::Base
  belongs_to :team
  serialize :position, Array
  
  has_many :positionings, :as => :positionable, :dependent => :destroy
  has_many :positions, :through => :positionings
  
  def position_list
    positions.pluck(:position).join(", ")
  end
  
end
