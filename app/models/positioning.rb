class Positioning < ActiveRecord::Base
  belongs_to :positionable, :polymorphic => true
  belongs_to :position
end
