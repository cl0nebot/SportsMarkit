class ClubsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :upgrade]
  before_action :correct_user!, only: [:edit, :destroy, :upgrade]
  before_action :find_club, except: [:index, :new, :create, :upgrade, :upgrade_club, :plan, :update]
  
  
  def index
    @clubs = Club.all
    @club = Club.new
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def new
    @object = Club.new
    @address = @object.build_address
  end
  
  def create
    @club = Club.new(club_params)
    if @club.save
      redirect_to @club
    else
      render :new
    end
  end
  
  def show
    @object = @club
    @teams = @club.teams
    shared_variables
    @manager_and_trainers = @club.manager_and_trainers
    @userless_managers_and_trainers = @club.userless_managers_and_trainers
    @admins = @club.admins
    @userless_admins = @club.userless_admins
    @facilities = @club.facilities
    @certifications = @club.club_certifications
  end
  
  def edit
    @object = @club
    @picture =  @object.photos.build
    @pictures = Photo.where(photo_owner_id: @object.id, photo_owner_type: @object.class.to_s, main: false)
    profile_picture_insert
  end
  
  def update
    @object = Club.find_by_slug!(request.referrer.split("clubs/").last.split("/").first)
    @profile_picture =  ProfilePicture.where(profile_picture_owner_id: @object.id, profile_picture_owner_type: @object.class.to_s).last
    @profile_pictures = ProfilePicture.where(profile_picture_owner_id: @object.id, profile_picture_owner_type: @object.class.to_s)
    @videos = @object.medias.where(category: "Video")
    @articles = @object.medias.where(category: "Article")
    @pictures = Photo.where(photo_owner_id: @object.id, photo_owner_type: @object.class.to_s, main: false)
    if @object.update_attributes(club_params)
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
    @club.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end
  
  def plan
    @club = Club.friendly.find(params[:club_id])
  end
  
  def upgrade
    @club = Club.friendly.find(params[:club_id])
  end
  
  def upgrade_school
    @club = Club.friendly.find(params[:club_id])
    stripe_token = params[:club][:stripe_token]
    
    begin
      if @club.stripe_customer_id.nil?
        
        if !stripe_token.present?
          #Emails.subscription_error(@school).deliver
          raise "Stripe token not present. Cannot process transaction."  
        end
        
        customer = Stripe::Customer.create(
          :email => @club.try(:email),
          :description => "#{@club.name} - #{@club.id}", #TODO make method
          :card => stripe_token,
          :plan => params[:club][:plan])
          
    #@school = @school.build_subscription(school_params)
    #@school.plan = params[:school][:plan]
    if @club.save
      #Emails.successful_subscription(@school, current_user).deliver
      #Emails.subscription_notification(@school).deliver
      redirect_to club_path(@club)
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
  
  def club_params
    params.require(:club).permit(:name, :classification, :category, :abbreviation, :phone_number, :email, :website, :slug, :stripe_token, :facebook, :twitter, :linkedin, :pinterest, :instagram, :foursquare, :youtube, :founded, :enrollment, :faculty, {address_attributes: [:id, :addressable_id, :addressable_type, :street_1, :street_2, :city, :state, :country, :postcode, :suite, :nickname, :default, :county, :latitude, :longitude, :gmaps]})  
  end
  
  def find_club
    @club = Club.friendly.find(params[:id])
  end
end

