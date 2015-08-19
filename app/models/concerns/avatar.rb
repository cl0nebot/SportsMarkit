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
    end
  end
  
  
end