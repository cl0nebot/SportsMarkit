class UserlessRole < ActiveRecord::Base
  
  has_many :positionings, :as => :positionable, :dependent => :destroy
  has_many :positions, :through => :positionings
  
  ["Athlete", "Coach", "Manager", "Admin", "Trainer"].each do |type|
    define_singleton_method type.downcase.pluralize do
      where(status: "Active", role: type)
    end
    
    define_singleton_method "pending_#{type.downcase.pluralize}" do
      where(status: "Pending", role: type)
    end
    
  end
  
  def self.staff_roles
    where(status: "Active", role: ["Manager", "Trainer", "Coach"])
  end
  
  def self.create_new_role(array, params={})
    array.compact.each do |role_type|
      role = create(
        first_name: params[:first_name],
        last_name: params[:last_name],
        roleable_type: "Team", 
        roleable_id: params[:team_id],  
        status: "Active", 
        role: role_type, 
        mobile_phone_number: params[:mobile_phone_number], 
        level: params[:level], 
        nickname: params[:nickname], 
        jersey_number: params[:jersey_number], 
        title: params[:title]
        )
        role.role == "Athlete" ? role.add_positions_to_role(params[:position_ids]) : "" 
    end
  end
  
  def add_positions_to_role(position_ids)
    position_ids.nil? ? "" : position_ids.each { |i| Positioning.create(position_id: i, positionable_id: id, positionable_type: "UserlessRole") }
  end
  
  
end
