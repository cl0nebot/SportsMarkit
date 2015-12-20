module Common
  extend ActiveSupport::Concern
  
  included do
    
    has_one :address, as: :addressable, dependent: :destroy
    accepts_nested_attributes_for :address, :reject_if => :all_blank, :allow_destroy => true
    
    has_many :announcements, as: :announceable, dependent: :destroy
    
    
  end
  
  module ClassMethods
    # class methods  
    def classifications
      school_ids = Team.all.pluck(:school_id).compact.uniq
      classifications = School.where(id: school_ids).pluck(:classification).compact.uniq
      categories = School.where(id: school_ids).pluck(:category).compact.uniq
      more = Team.all.pluck(:classification).compact.uniq
      classifications + categories + more
    end
    
    def role_types
      if self.to_s == "League"
        ["League Manager"]
      elsif self.to_s == "Team"
        ["Athlete", "Coach", "Trainer", "Team Manager", "Admin", "Parent"]
      elsif self.to_s == "School"
        ["School Manager", "Athletic Director"]
      elsif self.to_s == "User"
        ["Guardian"]
      elsif self.to_s == "Facility"
        ["Facility Manager"]
      elsif self.to_s == "Club"
        ["Club Director"]
      end
    end
    
    def custom_message_groups
      if self.to_s == "League"
        ["League Managers", "School Managers", "Athletic Directors"].sort
      elsif self.to_s == "Team"
        []
      elsif self.to_s == "School"
        ["School Managers", "Athletic Directors"].sort
      elsif self.to_s == "User"
        ["Parent"]
      elsif self.to_s == "Facility"
        ["School Managers", "Athletic Directors", "Facility Managers", "League Managers"].sort
      elsif self.to_s == "Club"
        ["Club Director"].sort
      end
    end
    
    def default_message_groups
       team_options =  ["Team Managers", "Athletes", "Coaches", "Trainers", "Guardians", "Admins" ].sort
    end
     
  end
  
  def owned_teams
    Team.where(teamable_type: self.class.to_s, teamable_id: id)
  end
  
  def connected_teams
    Connect.where(owner_type:"Team", owner_id: id, connectable_type: self.class.to_s)
    #TODO both ways
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
  
  def connected_schools
    Connect.where(owner_type:"School", owner_id: id, connectable_type: self.class.to_s)
  end
  
  def school_ids
    if self.class.to_s == "User"
      (all_teams.where(teamable_type: "School").pluck(:teamable_id) + roles.where(status: "Active", roleable_type: "School").pluck(:roleable_id)).uniq
    elsif self.class.to_s == "School"
      [self.id]
    elsif self.class.to_s == "Team"
      teamable_type == "School" ? [teamable_id] : []
    else
       (connected_schools.pluck(:id) + all_teams.where(teamable_type: "School").pluck(:teamable_id)).uniq
    end
  end
  
  def connected_clubs
    Connect.where(owner_type:"Club", owner_id: id, connectable_type: self.class.to_s)
    #TODO both ways
  end
  
  def club_ids
    if self.class.to_s == "User"
      (all_teams.where(teamable_type: "Club").pluck(:teamable_id) + roles.where(status: "Active", roleable_type: "Club").pluck(:roleable_id)).uniq
    elsif self.class.to_s == "Club"
      [self.id]
    elsif self.class.to_s == "Team"
      teamable_type == "Club" ? [teamable_id] : []
    else
       (connected_clubs.pluck(:id) + all_teams.where(teamable_type: "Club").pluck(:teamable_id)).uniq
    end
  end
  
  def connected_leagues
    league_ids = Connect.where(owner_type: self.class.to_s, owner_id: id, connectable_type: "League")
    #TODO both ways
  end
  
  def league_ids
    if self.class.to_s == "User"
      joined_league_ids = (all_teams.where(teamable_type: "League").pluck(:teamable_id) + roles.where(status: "Active", roleable_type: "League").pluck(:roleable_id)).uniq
      array = []
      team_ids.each { |id| array << Team.find(id).league_ids }
      connected_league_ids = array
      (joined_league_ids + connected_league_ids).flatten.flatten.uniq
    elsif self.class.to_s == "League"
      [self.id]
    elsif self.class.to_s == "Team"
      teamable_id = teamable_type == "League" ? [teamable_id] : []
      connected_league_ids = connected_leagues.pluck(:connectable_id)
      teamable_id + connected_league_ids
    else
      array = []
      team_ids.each { |id| array << Team.find(id).league_ids }
      connected_league_ids = array.flatten.flatten
    end
  end
  
  def leagues
    League.where(id: league_ids)
  end
  
  def all_schools
    School.where(id: school_ids)
  end
  
  def league_names
    leagues.pluck(:name).join(", ")
  end
  
  def owned_facilities
    Facility.where(facility_owner_id: id, facility_owner_type: self.class.to_s)
  end
  
  def used_facilities
    facility_ids = Connect.where(owner_type: self.class.to_s, owner_id: id, connectable_type: "Facility").pluck(:connectable_id)
    #facilities through teams
    Facility.where(id: facility_ids)
  end

  def facility_ids
    if self.class.to_s == "User"
      (owned_facilities.pluck(:id) + roles.where(status: "Active", roleable_type: "Facility").pluck(:roleable_id)).uniq
    elsif self.class.to_s == "Facility"
      [self.id]
    else 
      (owned_facilities.pluck(:id) + used_facilities.pluck(:id)).uniq
    end
  end
  
  def facilities
    Facility.where(id: facility_ids)
  end
  
  def all_teams
    Team.where(id: team_ids)
  end
  
  def teammates
    user_ids = Role.where(roleable_id: team_ids, status: "Active", roleable_type: "Team").pluck(:user_id)
    User.where(id: user_ids).uniq - [self]
  end
  
  def user_teams
    teams = Team.where(id: team_ids)
  end
  # "All","Facility Managers", "League Managers"]
  
  ["Athlete", "Coach", "Team Manager", "Admin", "Trainer", "Guardian", "School Manager", "Athletic Director", "Club Director", "League Manager", "Facility Manager"].each do |type|
    
    if ["Athlete", "Coach", "Team Manager", "Admin", "Trainer", "Guardian"].include?(type)
      owner = { owner: "Team", ids: "team_ids" }
    end
    
    if ["School Manager", "Athletic Director"].include?(type)
      owner = { owner: "School", ids: "school_ids" }
    end
    
    if ["Club Director"].include?(type)
      owner = { owner: "Club", ids: "club_ids" }
    end
    
    if ["League Manager"].include?(type)
      owner = { owner: "League", ids: "league_ids" }
    end
    
    if ["Facility Manager"].include?(type)
      owner = { owner: "Facility", ids: "facility_ids" }
    end
    
    formatted_type = type.gsub(" ", "_").downcase
    
    define_method "#{formatted_type}_roles" do
      Role.where(id: roles.send(formatted_type.pluralize).pluck(:id) + Role.where(roleable_type: owner[:owner], roleable_id: self.send(owner[:ids])).send(formatted_type.pluralize).pluck(:id))
    end
    
    define_method "pending_#{formatted_type}_roles" do
      Role.where(id: roles.send("pending_#{formatted_type.pluralize}") + Role.where(roleable_type: owner[:owner], roleable_id: self.send(owner[:ids])).send("pending_#{formatted_type.pluralize}").pluck(:id))
    end
    
    define_method "userless_#{formatted_type}_roles" do
      UserlessRole.where(id: userless_roles.send(formatted_type.pluralize) + UserlessRole.where(userless_type: owner[:owner], userless_id: self.send(owner[:ids])).send(formatted_type.pluralize).pluck(:id))
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
      UserlessRole.where(id: userless_roles.send(formatted_type.pluralize) + UserlessRole.where(userless_type: owner[:owner], userless_id: self.send(owner[:ids])).send(formatted_type.pluralize).pluck(:id))
    end        
  end

  def staff_roles
    if self.class.to_s == "Team"
      user_ids = roles.staff_roles + userless_roles.staff_roles
    else
      user_ids = roles.staff_roles + Role.where(roleable_type: "Team", roleable_id: self.team_ids).staff_roles + userless_roles.staff_roles + UserlessRole.where(userless_type: "Team", userless_id: self.team_ids).staff_roles 
    end
  end
  
  def unique_staff_roles
    if self.class.to_s == "Team"
      user_ids = roles.unique_staff_roles + userless_roles.unique_staff_roles
    else
      user_ids = roles.unique_staff_roles + Role.where(roleable_type: "Team", roleable_id: self.team_ids).unique_staff_roles + userless_roles.unique_staff_roles + UserlessRole.where(userless_type: "Team", userless_id: self.team_ids).unique_staff_roles 
    end
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
    user_ids = (team_managers.pluck(:id) + trainers.pluck(:id)).uniq
    User.where(id: user_ids)
  end
  
  def userless_managers_and_trainers
    UserlessRole.where(userless_type: "Team", userless_id: team_ids, role: ["Trainer", "Manager"], status: "Active")
    #(manager_relationships.pluck(:first_name, :last_name) + trainer_relationships.pluck(:first_name, :last_name)).uniq
  end
  

    
 
  
  # def is_athletic_director?(user)
 #    roles.where(status: "Active", role: "Athletic Director", user_id: user.id).present?
 #  end
  

  # def self.team_names
  #   self.school_team_names + self.non_school_team_names
  # end
  #
  

  
end
