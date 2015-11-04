class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :xeditable?
  before_action :track_online_status


  ALPHABET_ARRAY = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
  # users

  def new_user
    @user ||= User.new
  end

  def current_user
    @current_user ||= User.find_by_authentication_token(cookies[:authentication_token]) if cookies[:authentication_token]
  end
  
  def track_online_status
    if current_user
      @online_status = OnlineStatus.find_or_create_by(user_id: current_user.id).update(last_seen: Time.now)
    end
  end

  helper_method :new_user, :current_user
  
  #authentication

  def authenticate_user!
    redirect_to signup_path, alert: "Not authorized" if current_user.nil?
  end
  
  def authenticate_admin!
    redirect_to edit_user_path(current_user) unless current_user.admin?
  end

  def xeditable?
    true # Or something like current_user.xeditable?
  end
  
  def generate_temporary_password(first_name)
    first_part = first_name.delete(' ').downcase.reverse
    name_array = first_name.split("")
    array = []
    second_part = name_array.each do |letter|
      array << ALPHABET_ARRAY.index(letter)
    end
    first_part.last(3) + array.join.last(5) + first_part.first(3)
  end
  
  def authenticate_user!
    redirect_to signup_path, alert: "Not authorized" if current_user.nil?
  end
  
  def authenticate_user_account
    authenticate_user!
    unless current_user.admin? or current_user == User.friendly.find(params[:id])
      flash[:message] = "This is your account."
      redirect_to edit_user_path(current_user)
      #render :file => "public/401.html", :status => :unauthorized
    end
  end
  
  def authenticate_pending_athletic_director!
    authenticate_user!
    if current_user
      unless current_user.admin? or AthleticDirector.where(user_id: current_user.id, school_id: params[:school_id]).present?
        flash[:message] = "This is your account."
        redirect_to edit_user_path(current_user)
        #render :file => "public/401.html", :status => :unauthorized
      end
    end
  end
  
  def authenticate_athletic_director!
    authenticate_user!
    if current_user
      unless current_user.admin? or AthleticDirector.where(user_id: current_user.id, school_id: params[:school_id], accepted: true).present?
        flash[:message] = "This is your account."
        redirect_to edit_user_path(current_user)
        #render :file => "public/401.html", :status => :unauthorized
      end
    end
  end
  
  def authenticate_team_athletic_director!
    authenticate_user!
    if current_user
      school = Team.friendly.(params[:id]).school
      unless current_user.admin? or AthleticDirector.where(user_id: current_user.id, school_id: school.id, accepted: true).present?
        flash[:message] = "This is your account."
        redirect_to edit_user_path(current_user)
        #render :file => "public/401.html", :status => :unauthorized
      end
    end
  end
  
  def authenticate_team_admin!
    authenticate_user!
    if current_user
      school = Team.friendly.find(params[:id]).school
      unless current_user.admin? or AthleticDirector.where(user_id: current_user.id, school_id: school.id, accepted: true).present? or Relationship.where(user_id: current_user.id, admin: true).present? or Relationship.where(user_id: current_user.id, head: true).present?
        flash[:message] = "This is your account."
        redirect_to edit_user_path(current_user)
        #render :file => "public/401.html", :status => :unauthorized
      end
    end
  end
  
  def shared_variables
    @accepted_coaches = @object.accepted_coaches
    @userless_coaches = @object.userless_coaches
    @accepted_athletes = @object.accepted_athletes
    @userless_athletes = @object.userless_athletes
    @videos = @object.medias.where(category: "Video")
    @articles = @object.medias.where(category: "Article")
    @fans = @object.fans
    @events = @object.upcoming_events
    @pictures = Photo.where(photo_owner_id: @object.id, photo_owner_type: @object.class.to_s, main: false)
    @json = @object.to_gmaps4rails
    @class = @object.class
    
  end
  
  def profile_picture_insert
    @profile_picture =  ProfilePicture.where(profile_picture_owner_id: @object.id, profile_picture_owner_type: @object.class.to_s).empty? ? @object.profile_pictures.build : ProfilePicture.where(profile_picture_owner_id: @object.id, profile_picture_owner_type: @object.class.to_s).last
    @profile_pictures = ProfilePicture.where(profile_picture_owner_id: @object.id, profile_picture_owner_type: @object.class.to_s)
  end
  
  
  
end
