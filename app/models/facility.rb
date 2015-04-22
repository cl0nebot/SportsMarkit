class Facility < ActiveRecord::Base
  extend FriendlyId
  friendly_id :use_for_slug, use: :slugged
  acts_as_gmappable
  
  has_many :fans, as: :fannable
  has_many :event_facilities
  has_many :events, through: :event_facilities
  
  def gmaps4rails_address
  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.address_1}, #{self.city}, #{self.state}" 
  end
  
  def use_for_slug
    existing_facility = Facility.where('slug = ?', self.slug)
    if existing_facility.present?
      "#{name} #{self.city_and_state} #{existing_facility.count}"
    else
      "#{name} #{self.city_and_state}"
    end
  end
  
  def city_and_state
    "#{city}-#{state}"
  end
  
  def full_address
    
  end
  
end
