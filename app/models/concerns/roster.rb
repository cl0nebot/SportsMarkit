module Roster
  extend ActiveSupport::Concern

  def team_ids
    if self.class.to_s == "League"
      team_ids = TeamLeague.where(league_id: id).pluck(:team_id)
    else
     teams.pluck(:id)
   end
   
  end  
  
  def accepted_athletes
    if self.class.to_s == "Team"
      user_ids = Relationship.where(team_id: id, participant: true, accepted: true).pluck(:user_id)
      
    elsif self.class.to_s == "League"
      array = []
      teams.each do |team|
        array << team.accepted_athletes.pluck(:id)
      end
      return User.where(id: array.flatten.uniq)
    else
      rels = Relationship.where(team_id: team_ids, accepted: true, participant: true)
      user_ids = rels.pluck(:user_id)
    end
    users = User.where(id: user_ids )
  end
  
  def userless_athletes
    if self.class.to_s == "Team"
      UserlessRelationship.where(team_id: id, participant: true)
    else
      UserlessRelationship.where(team_id: team_ids, participant: true)
    end
  end
  
  def accepted_coaches
    if self.class.to_s == "Team"
      user_ids = Relationship.where(team_id: id, head: true, accepted: true).pluck(:user_id)
      
    elsif self.class.to_s == "League"
      array = []
      teams.each do |team|
        array << team.accepted_coaches.pluck(:id)
      end
      return User.where(id: array.flatten.uniq)
    else
      rels = Relationship.where(team_id: team_ids, accepted: true, head: true)
      user_ids = rels.pluck(:user_id)
    end
    users = User.where(id: user_ids )
  end
  
  def userless_coaches
    if self.class.to_s == "Team"
      UserlessRelationship.where(team_id: id, head: true)
    else
      UserlessRelationship.where(team_id: team_ids, head: true)
    end
  end
  
  def accepted_managers
    if self.class.to_s == "Team"
      user_ids = Relationship.where(team_id: id, manager: true, accepted: true).pluck(:user_id)
    else
      rels = Relationship.where(team_id: team_ids, accepted: true, manager: true)
      user_ids = rels.pluck(:user_id)
    end
    users = User.where(id: user_ids )
  end
  
  def userless_managers
    if self.class.to_s == "Team"
      UserlessRelationship.where(team_id: id, manager: true)
    else
      UserlessRelationship.where(team_id: team_ids, manager: true)
    end
  end
  
  def accepted_trainers
    if self.class.to_s == "Team"
      user_ids = Relationship.where(team_id: id, trainer: true, accepted: true).pluck(:user_id)
    else
      rels = Relationship.where(team_id: team_ids, accepted: true, trainer: true)
      user_ids = rels.pluck(:user_id)
    end
    users = User.where(id: user_ids )
    
  end
  
  def userless_trainers
    if self.class.to_s == "Team"
      UserlessRelationship.where(team_id: id, trainer: true)
    else
      UserlessRelationship.where(team_id: team_ids, trainer: true)
    end
  end
  
  def accepted_staff_members
    (accepted_coaches + accepted_trainers + accepted_managers).uniq
  end




end