class Payment < ActiveRecord::Base
  belongs_to :form
  validates :form, presence: true

  def total
    price + sm_fee + stripe_fee
  end
end