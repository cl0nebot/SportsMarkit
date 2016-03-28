class BankAccount < ActiveRecord::Base
  belongs_to :bankable, polymorphic: true
  
  def self.set_category(params={})
    params[:bank_account][:category] == "individual" ? "individual" : "corporation"
  end
  # email call backs  
  # Emails.bank_account_confirmation(@spa, current_user).deliver
  # Emails.bank_account_added_notification(@spa).deliver
  #updated
end
