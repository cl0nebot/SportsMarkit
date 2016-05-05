class Option < ActiveRecord::Base

  has_many :selected_options

  def fake_id
    @fake_id ||= id || SecureRandom.hex
  end
end
