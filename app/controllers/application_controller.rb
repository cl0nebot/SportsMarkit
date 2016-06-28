class ApplicationController < ActionController::Base
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

  def club_types
    ["Other"] + ["Adult Recreational", "Boys & Girls Club", "Youth Recreational", "Travel", "AAU", "USATF", "Little League Baseball", "Pop Warner", "AYFL", "Independent", "USTA", "US Youth Soccer", "NFL Play60", "MLB RBI", "College Intramural", "City/County Recreational", "Independent", "Fitness and Training"].sort
  end

  def ethnicity
    ["African American", "Caucasian", "Asian / Pacific Islander", "Native American", "Latino / Hispanic", "Multi-Racial", "Other"]
  end

  def lives_with
    ["Both Parents", "Mother", "Father", "Step Mother", "Step Father", "Grandparents","Other" ]
  end


  helper_method :new_user, :current_user, :club_types, :ethnicity, :lives_with

  #authentication

  def authenticate_admin!
    redirect_to edit_user_path(current_user) unless current_user.try(:admin?)
  end

  def xeditable?
    true # Or something like current_user.xeditable?
  end

  def authenticate_user!
    redirect_to signup_path, alert: "Not authorized" if current_user.nil?
  end

  def correct_user!
    authenticate_user!
    if ["teams", "schools", "users", "facilities", "leagues", "clubs"].include? params[:controller]
      unless params[:controller].camelcase.singularize.constantize.friendly.find(params[:id]).can_be_edited_by_user?(current_user)
        flash[:message] = "Unauthorized."
        redirect_to edit_user_path(current_user)
      end
    else
      param = params.keys.find{|key| key =~ /(\w+)_id/}
      @object = $1.capitalize.constantize.friendly.find(params[param])
      unless @object.can_be_edited_by_user?(current_user)
        flash[:message] = "Unauthorized."
        redirect_to edit_user_path(current_user)
      end
    end  
  end
  
  

  def authenticate_pending_athletic_director!
    authenticate_user!
    if
      unless current_user.admin? || Role.where(user_id: current_user.id, role: "Athletic Director", roleable_type: "School", status: "Pending", roleable_id: params[:school_id]).present?
        flash[:message] = "This is your account."
        redirect_to edit_user_path(current_user)
      end
    end
  end

  def authenticate_athletic_director!
    authenticate_user!
    if current_user
      unless current_user.admin? || Role.where(user_id: current_user.id, role: "Athletic Director", roleable_type: "School", status: "Active", roleable_id: params[:school_id]).present?
        flash[:message] = "This is your account."
        redirect_to edit_user_path(current_user)
      end
    end
  end

  def authenticate_team_athletic_director!
    authenticate_user!
    if current_user
      school = Team.friendly.(params[:id]).school
      unless current_user.admin? || Role.where(user_id: current_user.id, role: "Athletic Director", roleable_type: "School", status: "Active", roleable_id: school.id).present?
        flash[:message] = "This is your account."
        redirect_to edit_user_path(current_user)
      end
    end
  end


  def shared_variables
    # athletes
    @athletes = @object.athletes
    @userless_athletes = @object.userless_athletes

    # coaches
    @userless_coaches = @object.userless_coaches
    @coaches = @object.coaches

    # athletic directors
    @athletic_directors = @object.athletic_directors

    # media
    @videos = @object.medias.where(category: "Video")
    @articles = @object.medias.where(category: "Article")
    @pictures = Photo.where(photo_owner_id: @object.id, photo_owner_type: @object.class.to_s, main: false)
    @picture =  @object.photos.build

    # people
    @people = @object.people
    @userless_people = @object.userless_people

    # events
    @event = @object.events.build
    @events = @object.upcoming_events

    # fans
    @fans = @object.fans

    @json = @object.address.to_gmaps4rails
    @class = @object.class
  end

  def profile_picture_insert
    @profile_picture =  ProfilePicture.where(profile_picture_owner_id: @object.id, profile_picture_owner_type: @object.class.to_s).empty? ? @object.profile_pictures.build : ProfilePicture.where(profile_picture_owner_id: @object.id, profile_picture_owner_type: @object.class.to_s).last
    @profile_pictures = ProfilePicture.where(profile_picture_owner_id: @object.id, profile_picture_owner_type: @object.class.to_s)
  end

  def redirect_to_back(url = root_path)
    if request.referer.present?
      redirect_to :back
    else
      redirect_to url
    end
  end

end
