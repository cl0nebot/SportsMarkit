class BankAccountController < ApplicationController
  before_action :authenticate_user!
  # before_action :correct_user
  before_action :find_bankable
  
  def index
    @bank_account = @bankable.bank_account.nil? ? @bankable.build_bank_account : @bankable.bank_account
  end
  
  def create
    stripe_token = params[:stripe_token]
    category = BankAccount.set_category(params)
    
    begin
      if @bankable.stripe_recipient_id.nil?
        raise "Stripe token not present. Cannot process transaction."  if !stripe_token.present?
        recipient = Stripe::Recipient.create(:name => params[:bank_account][:name_on_account], :type => category, :bank_account => stripe_token)
        @bank_account = @bankabke.build_bank_account(bank_account_params)
        if @bank_account.save
          flash[:success] = "Bank Account added."
          redirect_to root_path
        else
          flash[:error] = "Oops. Something went wrong. Let's try again."
          redirect_to root_path
        end
        @bankable.update_attributes(stripe_recipient_id: recipient.id)
      end
    end

    rescue Stripe::StripeError => e
      # A generic stripe error message
      @error = e
      flash[:error] = "We could not accept your request."
      redirect_to root_path
  end
  
  def update
    @bank_account = @bankable.bank_account

    begin
      unless @bank_account.stripe_recipient_id.nil?
        recipient = Stripe::Recipient.retrieve(@bankable.stripe_recipient_id)
        recipient.name = params[:bank_account][:name_on_account]
        recipient.type = params[:bank_account][:category]
        recipient.bank_account = [:stripe_token]
        recipient.save
      end
    end

    if @bank_account.update_attributes(bank_account_params)
      @bank_account.update_attributes(name_on_account: params[:bank_account][:name_on_account])
      flash[:success] = "Your bank account information has been changed."
      redirect_to :back
    else
      flash.now[:error] = "Oops. Something went wrong."
      render :show
    end

  end
  
  protected
  
  def find_bankable
    param = params.keys.find{|key| key =~ /(\w+)_id/}
    @bankable = $1.capitalize.constantize.find(params[param])
  end
  
  def bank_account_params
    params.require(:recipient).permit(:name_on_account, :category, :bankable_id, :bankable_type, :stripe_token)
  end
  
  
end
  
 
   
    

  

    


