class Positioning < ActiveRecord::Base
  belongs_to :positionable, :polymorphic => true
  belongs_to :position
  validate :not_duplicate, on: :create
  
  def not_duplicate
    existing_positioning = Positioning.where(position_id: self.position_id, positionable_id: self.positionable_id, positionable_type: self.positionable_type)
    if existing_positioning.present?
      errors.add(:position_id, "#{Position.find(self.position_id).position} already for exists for this athlete.")
    end
  end
  

end
