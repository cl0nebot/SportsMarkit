class SchoolsController < ApplicationController
  before_action :authenticate_user!
  #before_action :authenticate_pending_athletic_director!, only: [:upgrade]
  #before_action :authenticate_athletic_director!, only: [:edit, :update, :destroy]
  before_action :find_school, except: [:index, :new, :create, :upgrade, :upgrade_school, :plan]
  
  
  def index
    @schools = School.all
    @school = School.new
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def new
    @school = School.new
  end
  
  def create
    @school = School.new(school_params)
    if @school.save
      redirect_to @school
    else
      render :new
    end
  end
  
  def show
    @object = @school
    @teams = @school.teams
    @athletes = @school.athletes
    shared_variables
    @manager_and_trainers = @school.manager_and_trainers
    @userless_managers_and_trainers = @school.userless_managers_and_trainers
    @admins = @school.admins
    @userless_admins = @school.userless_admins
    @people = @school.people
    @userless_people = @school.userless_people
    @facilities = @school.facilities
    @certifications = @school.school_certifications
  end
  
  def edit
    @object = @school
    @picture =  @object.photos.build
    @pictures = Photo.where(photo_owner_id: @object.id, photo_owner_type: @object.class.to_s, main: false)
    profile_picture_insert
  end
  
  def update
    if @school.update_attributes(school_params)
      respond_to do |format|
        format.js
        format.html { redirect_to :back }
      end
    else
      render :edit
    end
  end
  
  def destroy
    @school.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end
  
  def plan
    @school = School.friendly.find(params[:school_id])
  end
  
  def upgrade
    @school = School.friendly.find(params[:school_id])
  end
  
  def upgrade_school
    @school = School.friendly.find(params[:school_id])
    stripe_token = params[:school][:stripe_token]
    
    begin
      if @school.stripe_customer_id.nil?
        
        if !stripe_token.present?
          #Emails.subscription_error(@school).deliver
          raise "Stripe token not present. Cannot process transaction."  
        end
        
        customer = Stripe::Customer.create(
          :email => @school.try(:email),
          :description => "#{@school.name} - #{@school.id}", #TODO make method
          :card => stripe_token,
          :plan => params[:school][:plan])
          
    #@school = @school.build_subscription(school_params)
    #@school.plan = params[:school][:plan]
    if @school.save
      #Emails.successful_subscription(@school, current_user).deliver
      #Emails.subscription_notification(@school).deliver
      redirect_to school_path(@school)
    else
      #flash[:error] = "Oops. Something went wrong. Let's try again." 
      redirect_to :back
    end
    
    # @school.update_attributes(premium: true, stripe_customer_id: customer.id, stripe_subscription_id: customer.subscription.id)
    #@school.update_attributes(premium: true, stripe_customer_id: customer.id)
          
    end
          
    rescue Stripe::CardError => e
      # The card has been declined or
      # some other error has occured
      @error = e
      render :new
    end
  
  end 
  
  protected
  
  def school_params
    params.require(:school).permit(:name, :classification, :category, :abbreviation, :address_1, :address_2, :city, :state, :zip, :zip_ext, :latitude, :longitude, :gmaps, :phone_number, :email, :website, :slug, :stripe_token, :facebook, :twitter, :linkedin, :pinterest, :instagram, :foursquare, :youtube)  
  end
  end
  
  def find_school
    @school = School.friendly.find(params[:id])
  end
end

