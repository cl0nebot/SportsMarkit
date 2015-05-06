class Measurable < ActiveRecord::Base
  belongs_to :user

  def fake_id
    @fake_id ||= id || SecureRandom.hex
  end
end
