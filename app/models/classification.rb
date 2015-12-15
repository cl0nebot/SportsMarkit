class Classification < ActiveRecord::Base
  belongs_to :user
  validate :not_duplicate
  
  def not_duplicate
    existing_classification = Classification.where(user_id: self.user_id, classification: self.classification)
    if existing_classification.present?
      errors.add(:user_id, "#{self.classification} classification already exists for this user.")
    end
  end
end
