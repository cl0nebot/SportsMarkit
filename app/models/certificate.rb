class Certificate < ActiveRecord::Base
  belongs_to :user
  belongs_to :certification
  validates_presence_of :user_id, :expires, :expiration, :certification_id

end
