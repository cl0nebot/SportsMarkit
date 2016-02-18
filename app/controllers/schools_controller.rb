class SchoolsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :upgrade]
  before_action :correct_user!, only: [:edit, :destroy]
  #need correct user method here that uses school id instead of id
  before_action :find_school, except: [:index, :new, :create, :upgrade, :upgrade_school, :plan, :update]
  
  
  def index
   if stale?(:etag => ["schools-index", "v0"], :last_modified => School.maximum(:updated_at))
    @schools = School.all
        @object = School.new
        @address = @object.build_address
        respond_to do |format|
          format.js
          format.html
        end
    end
  end
  
  def new
    @object = School.new
    @address = @object.build_address
  end
  
  def create
    if (params[:school][:address_attributes][:street_1].present? && params[:school][:address_attributes][:city].present? || params[:school][:address_attributes][:state].present?)
      @school = School.new(school_params)
      if @school.save
        redirect_to @school
      else
        flash[:error] = "School needs a name and a valid address."
        redirect_to :back
      end
    else
      flash[:error] = "Address is invalid."
      redirect_to :back
    end
  end
  
  def show
    @object = @school
    @teams = @object.teams
    shared_variables
    @manager_and_trainers = @object.manager_and_trainers
    @userless_managers_and_trainers = @object.userless_managers_and_trainers
    @admins = @object.admins
    @userless_admins = @object.userless_admins
    @facilities = @object.facilities
    @certifications = @object.school_certifications
  end
  
  def edit
    @object = @school
    @picture =  @object.photos.build
    @pictures = Photo.where(photo_owner_id: @object.id, photo_owner_type: @object.class.to_s, main: false)
    profile_picture_insert
  end
  
  def update
    @object = School.find_by_slug!(request.referrer.split("schools/").last.split("/").first)
    @profile_picture =  ProfilePicture.where(profile_picture_owner_id: @object.id, profile_picture_owner_type: @object.class.to_s).last
    @profile_pictures = ProfilePicture.where(profile_picture_owner_id: @object.id, profile_picture_owner_type: @object.class.to_s)
    @videos = @object.medias.where(category: "Video")
    @articles = @object.medias.where(category: "Article")
    @pictures = Photo.where(photo_owner_id: @object.id, photo_owner_type: @object.class.to_s, main: false)
    if @object.update_attributes(school_params)
      respond_to do |format|
        format.html {redirect_to :back}
        format.js
        format.json { respond_with_bip(@object) } 
      end
    else
      respond_to do |format|
        format.html {redirect_to :back}
        format.js
        format.json { respond_with_bip(@object) } 
      end
      
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
    @object = @school
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
    params.require(:school).permit(:name, :classification, :category, :abbreviation, :description, :phone_number, :email, :website, :slug, :stripe_token, :facebook, :twitter, :linkedin, :pinterest, :instagram, :foursquare, :youtube, :founded, :enrollment, :faculty, {address_attributes: [:id, :addressable_id, :addressable_type, :street_1, :street_2, :city, :state, :country, :postcode, :suite, :nickname, :default, :county, :latitude, :longitude, :gmaps]})  
  end
  
  def find_school
    @school = School.friendly.find(params[:id])
  end
end

