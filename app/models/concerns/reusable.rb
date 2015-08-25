module Reusable
  extend ActiveSupport::Concern
  
  def owned_facilities
    Facility.where(facility_owner_id: id, facility_owner_type: self.class.to_s)
  end
  
  def used_facilities
    facility_ids = facility_links.pluck(:facility_id)
    Facility.where(id: facility_ids)
  end
  
  def social_media_present?
    if self.class.to_s == "User"
      [profile.facebook.present? , profile.linkedin.present? , profile.youtube.present?, profile.twitter.present?, profile.instagram.present?, profile.pinterest.present?, profile.foursquare.present?].include? true
    else
      [facebook.present? , linkedin.present? , youtube.present?, twitter.present?, instagram.present?, pinterest.present?].include? true
    end
  end
  
  def number_of_people_online
    array = []
    people.uniq.each do |p|
       if p.online_status.present?
         if p.online_status.last_seen > Time.now - 10.minutes
           array << 1
         end
       end
    end
    array.length
  end
  
  def last_activity
    array = []
    people.uniq.each do |p|
       if p.online_status.present?
         array << p.online_status.last_seen
       end
    end
    array.max
  end

  
end