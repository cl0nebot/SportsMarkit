class Option < ActiveRecord::Base
  def fake_id
    @fake_id ||= id || SecureRandom.hex
  end
end
