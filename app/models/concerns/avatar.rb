module Avatar
  extend ActiveSupport::Concern
  
  def avatar
    if self.class.to_s == "User"
      if user_profile_pictures.last.try(:id).blank?
        "http://hasslefreeliving.com/wp-content/uploads/2012/10/placeholder.gif"
      else
        user_profile_pictures.last.photo
      end
    elsif self.class.to_s == "UserlessRelationship"
      "http://hasslefreeliving.com/wp-content/uploads/2012/10/placeholder.gif"
    elsif ["School", "Facility", "Team", "League"].include? self.class.to_s
      if profile_pictures.last.try(:id).blank?
        "https://img-w.zeebox.com/images/z/f9b33d0f-d6f5-4676-98ea-e6254d7ad382.jpg"
      else
        profile_pictures.last.photo
      end
    end
  end
  
  
end