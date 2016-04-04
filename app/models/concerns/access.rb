module Access
  extend ActiveSupport::Concern
  #TODO we need it at all ?

  def can_be_edited_by_user?(current_user)
    return false if current_user.nil?
    return true if current_user.admin?
    %w[user school team club facility league event].each do |object|
      self.send("#{object}_can_be_edited_by_user?", current_user) == true ? (return true) : (return false)
    end
    return false
  end

  def team_can_be_edited_by_user?(current_user)
    if self.instance_of?(Team)
      if self.teamable.present?
        supervisory_roles = ["Athletic Director", "League Manager", "Admin", "Club Director", "Club Manager", "School Manager"]
        return true if Role.where(user_id: current_user.id, status: "Active", roleable_type: self.teamable.class.to_s, roleable_id: self.teamable.id, role: supervisory_roles).present?
      else
        return true if Role.where(user_id: current_user.id, status: "Active", roleable_type: self.class.to_s, roleable_id: self.id, role:["Admin"]).present?
      end
      return false
    end
  end
  
  def league_can_be_edited_by_user?(current_user)
    if self.instance_of?(League)
      return true if Role.where(user_id: current_user.id, status: "Active", roleable_type: self.class.to_s, roleable_id: self.id, role: ["League Manager", "League Director"] ).present?
      return false
    end
  end
  
  def event_can_be_edited_by_user?(current_user)
    if self.instance_of?(Event)
      return true if (self.user_id == current_user.id)
      object = eventable_type.constantize.find(eventable_id)
      return true if object.can_be_edited_by_user?(current_user)
      return false
    end
  end
  
  def user_can_be_edited_by_user?(current_user)
    if self.instance_of?(User)
      return true if (self.id == current_user.id)
      #return true if TODO add parent
      return false
    end
  end
  
  def school_can_be_edited_by_user?(current_user)
    if self.instance_of?(School)
      return true if Role.where(user_id: current_user.id, status: "Active", roleable_type: self.class.to_s, roleable_id: self.id, role: ["Athletic Director", "School Manager"] ).present?
      return false
    end
  end
  
  def club_can_be_edited_by_user?(current_user)
    if self.instance_of?(Club)
      return true if Role.where(user_id: current_user.id, status: "Active", roleable_type: self.class.to_s, roleable_id: self.id, role: ["Club Director", "Club Manager"] ).present?
      return false
    end
  end
  
  def facility_can_be_edited_by_user?(current_user)
    if self.instance_of?(Facility)
      return true if Role.where(user_id: current_user.id, status: "Active", roleable_type: self.class.to_s, roleable_id: self.id, role: ["Facility Manager"]).present?
      if facility_owner_id.present?
        return true if (facility_owner_type == "User" && facility_owner_id == current_user.id)
        return true if facility_owner_type.constantize.find(facility_owner_id).can_be_edited_by_user?(current_user)
      end
      return false
    end
  end
end