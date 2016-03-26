class Certificate < ActiveRecord::Base
  mount_uploader :file, PdfUploader

  belongs_to :user
  belongs_to :certification

  scope :expires, -> { where(expires: true) }
  scope :expires_in, -> (days) { expires.where(expiration: Date.today - days.days) }
  scope :expired, -> { expires.where("expiration < ?", Date.today) }

  validates_presence_of :user_id, :expiration, :certification_id

  after_create :delete_if_no_certification

  def delete_if_no_certification
    self.delete if certification_id.nil?
  end

  def fake_id
    @fake_id ||= id || SecureRandom.hex
  end
end
