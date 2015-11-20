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
      [self.id]
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
  
  ["Athlete", "Coach", "Manager", "Admin", "Trainer", "Athletic Director"].each do |type|
    
    formatted_type = type.gsub(" ", "_").downcase
    
    #TODO add athletic director to admin?
    
    define_method "#{formatted_type}_roles" do
      p formatted_type
      Role.where(id: roles.send(formatted_type.pluralize).pluck(:id) + Role.where(roleable_type: "Team", roleable_id: self.team_ids).send(formatted_type.pluralize).pluck(:id))
    end
    
    define_method "pending_#{formatted_type}_roles" do
      Role.where(id: roles.send("pending_#{formatted_type.pluralize}") + Role.where(roleable_type: "Team", roleable_id: self.team_ids).send("pending_#{formatted_type.pluralize}").pluck(:id))
    end
    
    define_method "userless_#{formatted_type}_roles" do
      UserlessRole.where(userless_roles.send(formatted_type.pluralize) + UserlessRole.where(userless_type: "Team", userless_id: self.team_ids).send(formatted_type.pluralize).pluck(:id))
    end
    
    define_method "all_#{formatted_type}_roles" do
      send("#{formatted_type}_roles") + send("pending_#{formatted_type}_roles") + send("userless_#{formatted_type}_roles")
    end
    
    define_method formatted_type.pluralize do
      user_ids = send("#{formatted_type}_roles").pluck(:user_id) - [self.class.to_s == "User" ? self.id : ""]
      User.where(id: user_ids.uniq) 
    end

    define_method "pending_#{formatted_type.pluralize}" do
      user_ids = send("pending_#{formatted_type}_roles").pluck(:user_id) - [self.class.to_s == "User" ? self.id : ""]
      User.where(id: user_ids).uniq 
    end

    define_method "userless_#{formatted_type.pluralize}" do      
      UserlessRole.where(userless_roles.send(formatted_type.pluralize) + UserlessRole.where(userless_type: "Team", userless_id: self.team_ids).send(formatted_type.pluralize).pluck(:id))
    end    
    
  end
  
  def staff_roles
    user_ids = roles.staff_roles + Role.where(roleable_type: "Team", roleable_id: self.team_ids).staff_roles + userless_roles.staff_roles + UserlessRole.where(userless_type: "Team", userless_id: self.team_ids).staff_roles 
  end
  
  def accepted_staff_members
    user_ids = roles.staff_roles.pluck(:user_id) + Role.where(roleable_type: "Team", roleable_id: self.team_ids).staff_roles.pluck(:user_id) - [self.class.to_s == "User" ? self.id : ""]
    User.where(id: user_ids).uniq 
  end
  
  def people
    User.where(id: Role.where(roleable_type: "Team", roleable_id: team_ids, status: "Active").pluck(:user_id).uniq)
  end
  
  def userless_people
    UserlessRole.where(userless_type: "Team", userless_id: team_ids, status: "Active")
  end

  def manager_and_trainers
    user_ids = (managers.pluck(:id) + trainers.pluck(:id)).uniq
    User.where(id: user_ids)
  end
  
  def userless_managers_and_trainers
    UserlessRole.where(userless_type: "Team", userless_id: team_ids, role: ["Trainer", "Manager"], status: "Active")
    #(manager_relationships.pluck(:first_name, :last_name) + trainer_relationships.pluck(:first_name, :last_name)).uniq
  end


              
              
  
  
end
