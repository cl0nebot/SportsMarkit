class Certificate < ActiveRecord::Base
  mount_uploader :file, PdfUploader

  belongs_to :user
  belongs_to :certification
  validates_presence_of :user_id, :expiration, :certification_id

  after_create :delete_if_no_certification

  def delete_if_no_certification
    self.delete if certification_id.nil?
  end

  def fake_id
    @fake_id ||= id || SecureRandom.hex
  end
end
