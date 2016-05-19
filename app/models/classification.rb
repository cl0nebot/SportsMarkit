class Classification < ActiveRecord::Base
  belongs_to :user
  validate :not_duplicate, on: :create
  
  def self.description(classification)
    case classification
    when "Student Athlete"
      "I am a student."
    when "Athlete"
      "I play on recreational teams"
    when "Coach"
      "I coach athletes"
    when "Guardian"
      "I am a parent of an athlete"
    when "Athletic Director"
      "I manage schools"
    when "Club Director"
      "I manage clubs"
    when "School Manager"
      "I manage schools"
    when "Team Manager"
      "I manage teams"
    end
  end
  
  def not_duplicate
    existing_classification = Classification.where(user_id: self.user_id, classification: self.classification)
    if existing_classification.present?
      errors.add(:user_id, "#{self.classification} classification already exists for this user.")
    end
  end
end
