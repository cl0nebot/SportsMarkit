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
      
    elsif self.class.to_s == "Club"
      if Role.where(user_id: current_user.id, status: "Active", roleable_type: "Club", roleable_id: self.id, role: ["Club Director"] ).present?
        true
      else
        false
      end
    elsif self.class.to_s == "Facility"
      if Role.where(user_id: current_user.id, status: "Active", roleable_type: "Facility", roleable_id: self.id, role: ["Facility Manager"] ).present?
        true
      elsif facility_owner_id.present?
        if (facility_owner_type == "User" && facility_owner_id == current_user.id)
          true
        elsif facility_owner_type.constantize.find(facility_owner_id).can_be_edited_by_user?(current_user)
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
  
  def can_verify_user?(current_user)
    true
  end
  
  
  

end