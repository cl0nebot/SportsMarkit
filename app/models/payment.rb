class Payment < ActiveRecord::Base
  belongs_to :form
  validates :form, presence: true
end