module Link
  extend ActiveSupport::Concern
  
  module ClassMethods
    # class methods    
  end
  
  def owned_teams
    Team.where(teamable_type: self.class.to_s, teamable_id: id)
  end
  
  def connected_teams
    Connect.where(owner_type: self.class.to_s, owner_id: id, connectable_type: "Team")
  end
  
  def team_ids
    if self.class.to_s == "User"
      (owned_teams.pluck(:id) + roles.where(status: "Active", roleable_type: "Team").pluck(:roleable_id)).uniq
    elsif self.class.to_s == "Team"
    else 
      (owned_teams.pluck(:id) + connected_teams.pluck(:id)).uniq
    end
  end
  
  def teammates
    user_ids = Role.where(roleable_id: team_ids, status: "Active", roleable_type: "Team").pluck(:user_id)
    User.where(id: user_ids).uniq - [self]
  end
  
  def user_teams
    teams = Team.where(id: team_ids)
  end
  
  ["Athlete", "Coach", "Manager", "Admin", "Trainer"].each do |type|
    
    define_method "#{type.downcase}_roles" do
      roles.send(type.downcase.pluralize)
    end
    
    define_method "pending_#{type.downcase}_roles" do
      roles.send("pending_#{type.downcase.pluralize}")
    end
    
    define_method "userless_#{type.downcase}_roles" do
      userless_roles.send(type.downcase.pluralize)
    end
    
    define_method "all_#{type.downcase}_roles" do
      roles.send(type.downcase.pluralize) + roles.send("pending_#{type.downcase.pluralize}") + userless_roles.send(type.downcase.pluralize)
    end
    
    define_method type.downcase.pluralize do
      user_ids = send("#{type.downcase}_roles").pluck(:user_id)
      User.where(id: user_ids).uniq - [self.class.to_s == "User" ? self : ""]
    end

    define_method "pending_#{type.downcase.pluralize}" do
      user_ids = send("pending_#{type.downcase}_roles").pluck(:user_id)
      User.where(id: user_ids).uniq - [self.class.to_s == "User" ? self : ""]
    end

    define_method "userless_#{type.downcase.pluralize}" do      
      userless_roles.send(type.downcase.pluralize)
    end
    
  end
  
  def staff_roles
    user_ids = roles.staff_roles + userless_roles.staff_roles
  end
  
  def accepted_staff_members
    user_ids = roles.staff_roles.pluck(:user_id)
    User.where(id: user_ids).uniq - [self.class.to_s == "User" ? self : ""]
  end
  
end
