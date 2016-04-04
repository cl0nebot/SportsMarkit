class Measurable < ActiveRecord::Base
  belongs_to :user
  has_many :verifications, as: :verifiable, dependent: :destroy
  has_many :verifiers, through: :verifications, source: :user

  def fake_id
    @fake_id ||= id || SecureRandom.hex
  end

  def verified?
    verifications_count > 0
  end
end
