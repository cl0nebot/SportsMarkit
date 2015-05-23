class Tournament < ActiveRecord::Base
  belongs_to :user
  extend FriendlyId
  friendly_id :use_for_slug, use: [:slugged]
  
  has_many :events, as: :eventable
  accepts_nested_attributes_for :events, :reject_if => :all_blank, :allow_destroy => true
  
  def use_for_slug
    existing_tournament = Tournament.where('slug = ?', self.slug)
    if existing_tournament.present?
      "#{self.name} #{existing_tournament.count}"
    else
      "#{self.name}"
    end
  end
end
