module StripeRegistration
  extend ActiveSupport::Concern
  
  def create_customer(params)
    customer = Stripe::Customer.create(:email => email, :description => name, :card => params[:stripe_token])
    update_attributes(stripe_customer_id: customer.id)
    customer
  end
  
  def retrieve_customer
    Stripe::Customer.retrieve(stripe_customer_id)
  end
  
  def customer(params={})
    stripe_customer_id ? retrieve_customer : create_customer(params)
  end
  
  def create_stripe_charge(customer_id, amount)
    Stripe::Charge.create({
      :customer => customer_id,
      :amount => amount,
      :currency => "usd",
      :description => 'SportsMarkit Registration'
      # :destination => model.constantize.find(id).stripe_account_id
    })  
  end
  
  def process_transaction(params={}, amount)
    stripe_customer = self.customer(params)
    create_stripe_charge(stripe_customer.id, amount)
  end

  
  
  
end