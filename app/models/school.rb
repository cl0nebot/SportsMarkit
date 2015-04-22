class School < ActiveRecord::Base
  extend FriendlyId
  friendly_id :use_for_slug, use: :slugged
  acts_as_gmappable
  
  has_many :fans, as: :fannable
  #has_many :event_facilities, as: :reservable
  has_many :teams
  
  def gmaps4rails_address
  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.address_1}, #{self.city}, #{self.state}" 
  end
  
  
  def use_for_slug
    existing_school = School.where('slug = ?', self.slug)
    if existing_school.present?
      "#{name} #{self.city_and_state} #{existing_school.count}"
    else
      "#{name} #{self.city_and_state}"
    end
  end
  
  def city_and_state
    "#{city}-#{state}"
  end
end
