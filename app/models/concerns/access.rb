module Access
  extend ActiveSupport::Concern
  
  
  def can_be_edited_by_user?(current_user) #TODO make sure everything is covered: events, facility, user, team, school, league, club
    if current_user.nil?
      false
    elsif current_user.admin?
      true
    elsif self.class.to_s == "Event"
      if user_id == current_user.id
        true
      else
        object = eventable_type.constantize.find(eventable_id)
        if object.can_be_edited_by_user?(current_user)
          true
        else
          false
        end
      end
      
    elsif self.class.to_s == "User"
      self.id == current_user.id ? true : false
    elsif self.roles.where(user_id: current_user.id, status: "Active", role: ["Athletic Director", "Team Manager", "League Manager", "Coach", "Admin"]).present?
      true
    elsif 1==2
      
    elsif self.class.to_s == "Team"
      if self.teamable.present? 
        if Role.where(user_id: current_user.id, status: "Active", roleable_type: self.teamable.class.to_s, roleable_id: self.teamable.id, role: ["Athletic Director", "League Manager", "Admin"] ).present?
          true
        else
          false
        end
      else
        false
      end
   
    else
      false
    end
  end
  
  
  

end