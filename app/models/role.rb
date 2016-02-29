class Role < ActiveRecord::Base
  belongs_to :roleable, polymorphic: true
  belongs_to :user
  
  has_many :positionings, :as => :positionable, :dependent => :destroy
  has_many :positions, :through => :positionings
  validate :not_duplicate, on: :create
  
  def not_duplicate
    existing_role = Role.where(user_id: self.user_id, role: self.role, roleable_id: self.roleable_id, roleable_type: self.roleable_type)
    if existing_role.present?
      errors.add(:user_id, "#{self.role} role already exists for this user.")
    end
  end
  
  ["Athlete", "Coach", "Team Manager", "Admin", "Trainer", "Athletic Director", "Guardian", "School Manager", "Athletic Director", "Club Director", "League Manager", "Facility Manager"].each do |type|
    
    formatted_type = type.gsub(" ", "_").downcase
    
    define_singleton_method formatted_type.pluralize do
      where(status: "Active", role: type)
    end
    
    define_singleton_method "pending_#{formatted_type.pluralize}" do
      where(status: "Pending", role: type)
    end
  end
  
  def self.staff_roles
    where(status: "Active", role: ["Team Manager", "Trainer", "Coach", "Athletic Director"])
  end
  
  def self.unique_staff_roles
    array =[]
    self.staff_roles.pluck(:user_id).uniq.each do |id|
      array << where(status: "Active", role: ["Team Manager", "Trainer", "Coach", "Athletic Director"], user_id: id).last.id
    end
    Role.where(id: array)
  end

  
  def self.create_new_roles(user_id, array, params={})
    array.compact.each do |role_type|
      role = create_new_role(user_id, role_type, params)
      role.role == "Athlete" ? role.add_positions_to_role(params[:position_ids]) : ""
    end
  end

  def self.create_new_role(user_id, role_type, params)
    create(
        roleable_type: "Team",
        roleable_id: params[:team_id],
        user_id: user_id,
        status: "Active",
        role: role_type,
        mobile_phone_number: params[:mobile_phone_number],
        level: params[:level],
        nickname: params[:nickname],
        jersey_number: params[:jersey_number],
        title: params[:title]
    )
  end
  
  def add_positions_to_role(position_ids)
    position_ids.nil? ? "" : position_ids.each { |i| Positioning.create(position_id: i, positionable_id: id, positionable_type: "Role") }
  end
  
  def position_list
    positions.pluck(:position).join(", ")
  end
  
  # def head_position_list
 #    "#{'Coach' if head?}#{', ' if (head? && (trainer? || manager? ))}#{'Trainer' if trainer?}#{', ' if (manager? && trainer?)}#{'Manager' if manager?}"
 #  end
 #
 #  def titles_list
 #    "#{'Athlete' if participant?}#{', ' if(participant? &&(trainer? || head? || manager? ))}#{'Coach' if head?}#{', ' if (head? && (trainer? || manager? ))}#{'Trainer' if trainer?}#{', ' if (manager? && trainer?)}#{'Manager' if manager?}"
 #  end
 #
 #  def athlete?
 #    (participant? && accepted == true) ? true : false
 #  end
 #
 #  def coach?
 #    (head? && accepted == true) ? true : false
 #  end
  
  
end
