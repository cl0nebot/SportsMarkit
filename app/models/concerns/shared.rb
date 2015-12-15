module Shared
  extend ActiveSupport::Concern
  
  included do
     has_many :fans, as: :fannable, dependent: :destroy
     has_many :teams, as: :teamable, dependent: :destroy
     has_many :medias, as: :mediable
  end
  
  module ClassMethods
    # class methods
    
    def object_names
      pluck(:name)
    end
    
    def object_json
      array = []
      self.all.each do |object|
        array << {name: object.proper_name, link: Rails.env.production? ? "http://www.sportsmarkit.com/#{self.to_s.downcase.pluralize}/#{object.slug}" : "http://localhost:3000/#{self.to_s.downcase.pluralize}/#{object.slug}"}
      end
      array
    end
      
  end
  
  def proper_name
    if self.class.to_s == "User"
      full_name
    elsif self.class.to_s == "Facility"
      if facility_owner_id.nil?
        name
      else
        "#{facility_owner_type.constantize.find(facility_owner_id).name} #{name}"
      end
    elsif self.class.to_s == "Team"
      if teamable_id.present?
        "#{teamable_type.constantize.find(teamable_id).name} #{name}" 
      else
        name
      end
    else
      name
    end
  end
  
  
  
  
  
  
  
  
  
  def general_information_present?
    [number_of_students.present? , motto.present? , colors.present?, number_of_teams.present?, mascot.present?].include? true
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
  
  # def is_premium?
  #   if teamable_id.present?
  #     if teamable_type == "School"
  #       if Schoo.find(teamable_id).premium?
  #         true
  #       else
  #         false
  #       end
  #     else
  #       #TODO do something for non-school premiums
  #     end
  #   else
  #     if premium?
  #       true
  #     else
  #       false
  #     end
  #   end
  # end

  
end