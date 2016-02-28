class UserlessRole < ActiveRecord::Base
  include Images
  
  has_many :positionings, :as => :positionable, :dependent => :destroy
  has_many :positions, :through => :positionings
  
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
    self.staff_roles.pluck(:first_name, :last_name).uniq.each do |first, last|
      array << where(status: "Active", role: ["Team Manager", "Trainer", "Coach", "Athletic Director"], first_name: first, last_name: last).last.id
    end
    UserlessRole.where(id: array)
  end
  
  def self.create_new_roles(array, params={})
    array.compact.each do |role_type|
      role = create_new_role(role_type, params)
      role.role == "Athlete" ? role.add_positions_to_role(params[:position_ids]) : ""
    end
  end

  def self.create_new_role(role_type, params)
    create(
      first_name: params[:first_name],
      last_name: params[:last_name],
      userless_type: "Team",
      userless_id: params[:team_id],
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
    position_ids.nil? ? "" : position_ids.each { |i| Positioning.create(position_id: i, positionable_id: id, positionable_type: "UserlessRole") }
  end
  
  def position_list
    positions.pluck(:position).join(", ")
  end
  
  
end
