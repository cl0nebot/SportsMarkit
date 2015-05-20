class Certificate < ActiveRecord::Base
  belongs_to :user
  belongs_to :certification
  validates_presence_of :user_id, :expiration, :certification_id

  def fake_id
    @fake_id ||= id || SecureRandom.hex
  end
end
