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
    elsif self.class.to_s == "School"
      if profile_pictures.last.try(:id).blank?
        "thumbs/school.jpg"
      else
        profile_pictures.last.photo
      end
    elsif self.class.to_s == "League"
      if profile_pictures.last.try(:id).blank?
        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/Color_icon_gray_v2.svg/2000px-Color_icon_gray_v2.svg.png"
      else
        profile_pictures.last.photo
      end
    elsif self.class.to_s == "Team"
      if profile_pictures.last.try(:id).blank?
        "placeholders/team-placeholder.png"
      else
        profile_pictures.last.photo
      end
    elsif self.class.to_s == "Facility" 
      if profile_pictures.last.try(:id).blank?
        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/Color_icon_gray_v2.svg/2000px-Color_icon_gray_v2.svg.png"
      else
        profile_pictures.last.photo
      end
    end
  end
  
  
  
end