class UserlessRelationship < ActiveRecord::Base
  # include Avatar
  # belongs_to :team
  # serialize :position, Array
  #
  # has_many :positionings, :as => :positionable, :dependent => :destroy
  # has_many :positions, :through => :positionings
  #
  # def position_list
  #   positions.pluck(:position).join(", ")
  # end
  #
  # def head_position_list
  #   "#{'Coach' if head?}#{', ' if (head? && (trainer? || manager? ))}#{'Trainer' if trainer?}#{', ' if (manager? && trainer?)}#{'Manager' if manager?}"
  # end
  #
  # def titles_list
  #   "#{'Athlete' if participant?}#{', ' if(participant? &&(trainer? || head? || manager? ))}#{'Coach' if head?}#{', ' if (head? && (trainer? || manager? ))}#{'Trainer' if trainer?}#{', ' if (manager? && trainer?)}#{'Manager' if manager?}"
  # end
  
end
