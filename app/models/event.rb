class Event < ActiveRecord::Base
  belongs_to :eventable, polymorphic: true
  belongs_to :user
  extend FriendlyId
  friendly_id :use_for_slug, use: :slugged
  has_many :attendees
  
  def use_for_slug
    existing_event = Event.where('slug = ?', self.slug)
    if existing_event.present?
      "#{Time.now.to_i} #{self.title} #{existing_event.count}"
    else
      "#{Time.now.to_i} #{self.title}"
    end
  end
  
  
  
end
