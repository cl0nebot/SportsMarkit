class Media < ActiveRecord::Base
  belongs_to :mediable, polymorphic: true

  def fake_id
    @fake_id ||= id || SecureRandom.hex
  end
end
