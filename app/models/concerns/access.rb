module Access
  extend ActiveSupport::Concern

  def can_edit_team?(object)
    if Relationship.where(user_id: id, head: true, team_id: object.id).present?
      true
    elsif AthleticDirector.where(user_id: id, school_id: object.school_id).present?
      true
    elsif admin?
      true
    else
      false
    end
  end

  def can_edit_school?(object)
    if AthleticDirector.where(user_id: id, school_id: object.id).present?
      true
    elsif admin?
      true
    else
      false
    end
  end

  def can_edit_league?(object)
    if LeagueManager.where(user_id: id, league_id: object.id).present?
      true
    elsif admin?
      true
    else
      false
    end
  end
  
  def can_edit_facility?(object)
    
  end
  
  def can_edit_user?(object)
    id == object.id
  end
  
  def can_edit_object?(object)
    if admin?
      true
    elsif object.class.to_s == "Team"
      can_edit_team?(object)
    elsif object.class.to_s == "School"
      can_edit_school?(object)
    elsif object.class.to_s == "League"
      can_edit_league?(object)
    elsif object.class.to_s == "Facility"
      can_edit_facility?(object)
    elsif object.class.to_s == "User"
      can_edit_user?(object)
    end
    
  end

end