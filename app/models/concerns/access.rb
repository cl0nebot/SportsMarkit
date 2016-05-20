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
        Role.where(user_id: current_user.id, status: "Active", roleable_type: self.teamable.class.to_s, roleable_id: self.teamable.id, role: supervisory_roles).present?
      else
        Role.where(user_id: current_user.id, status: "Active", roleable_type: self.class.to_s, roleable_id: self.id, role:["Admin"]).present?
      end
    end
  end
  
  def league_can_be_edited_by_user?(current_user)
    if self.instance_of?(League)
      Role.where(user_id: current_user.id, status: "Active", roleable_type: self.class.to_s, roleable_id: self.id, role: ["League Manager", "League Director"] ).present?
    end
  end
  
  def event_can_be_edited_by_user?(current_user)
    if self.instance_of?(Event)
      (self.user_id == current_user.id) || eventable_type.constantize.find(eventable_id).can_be_edited_by_user?(current_user)
    end
  end
  
  def user_can_be_edited_by_user?(current_user)
    if self.instance_of?(User)
      id == current_user.id
    end
  end
  
  def school_can_be_edited_by_user?(current_user)
    if self.instance_of?(School)
      Role.where(user_id: current_user.id, status: "Active", roleable_type: self.class.to_s, roleable_id: self.id, role: ["Athletic Director", "School Manager"] ).present?
    end
  end
  
  def club_can_be_edited_by_user?(current_user)
    if self.instance_of?(Club)
      Role.where(user_id: current_user.id, status: "Active", roleable_type: self.class.to_s, roleable_id: self.id, role: ["Club Director", "Club Manager"] ).present?
    end
  end
  
  def facility_can_be_edited_by_user?(current_user)
    if self.instance_of?(Facility)
      return true if Role.where(user_id: current_user.id, status: "Active", roleable_type: self.class.to_s, roleable_id: self.id, role: ["Facility Manager"]).present?
      if facility_owner_id.present?
        return (facility_owner_type == "User" && facility_owner_id == current_user.id) || facility_owner_type.constantize.find(facility_owner_id).can_be_edited_by_user?(current_user)
      end
    end
  end
end