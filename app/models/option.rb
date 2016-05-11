class Option < ActiveRecord::Base
  FEE = {'SM_FEE' => 5, 'STRIPE_FEE' => 3}

  has_many :selected_options

  def fake_id
    @fake_id ||= id || SecureRandom.hex
  end

  def grand_price
    price + sm_fee + stripe_fee
  end

  def sm_fee
    price.to_f / 100 * FEE['SM_FEE']
  end

  def stripe_fee
    price.to_f / 100 * FEE['STRIPE_FEE']
  end
end
