class UpgradesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user!
  before_action :find_object
  
  
  def new
  end

  def create
    stripe_token = params[:stripe_token]

    begin
      if @object.stripe_customer_id.nil?

        if !stripe_token.present?
          raise "Stripe token not present. Cannot process transaction."
        end

        customer = Stripe::Customer.create(
          :email => @object.try(:email),
          :description => "#{@object.name} - #{@object.id}", #TODO make method
          :card => stripe_token,
        :plan => params[:plan])

        if @object.save
          redirect_to send("#{@object.class.name.downcase}_path", @object)
        else
          redirect_to :back
        end
      end

    rescue Stripe::CardError => e
      # The card has been declined or
      # some other error has occured
      @error = e
      render :new
    end
  end

  def find_object
    id_column = (["school_id", "facility_id", "club_id", "league_id"] & params.keys)[0]
    klass = id_column.match(/([\w_]+)_id/)[1].capitalize.constantize
    @object = klass.find(params[id_column])
  end
end