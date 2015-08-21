module Access
  extend ActiveSupport::Concern

  def can_edit_team?(team)
    if Relationship.where(user_id: id, head: true, team_id: team.id).present?
      true
    elsif AthleticDirector.where(user_id: id, school_id: team.school_id).present?
      true
    elsif admin?
      true
    else
      false
    end
  end

  def can_edit_school?(school)
    if AthleticDirector.where(user_id: id, school_id: school.id).present?
      true
    elsif admin?
      true
    else
      false
    end
  end

  def can_edit_league?(league)
    if LeagueManager.where(user_id: id, league_id: league.id).present?
      true
    elsif admin?
      true
    else
      false
    end
  end
  
  def can_edit_facility?(facility)
    
  end
  
  def can_edit_user?(user)
    id == user.id
  end

end