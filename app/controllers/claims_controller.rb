class ClaimsController < ApplicationController
  before_action :load_claimable_schools
  require 'twilio-ruby'

  def onboard
  end

  def partner_initial_claim
      @ip_address = request.remote_ip
      #for sign up
      @user = User.new(user_params)
      if @user.save
        Profile.create(user_id: @user.id, focus: [], specialties: [], skills: [], injuries: [], current_ailments: [])
        AthleticDirector.create(user_id: @user.id, school_id: params[:user][:school_ids])
        cookies.permanent[:authentication_token] = @user.authentication_token
        redirect_to new_school_upgrade_path(params[:user][:school_ids])

      else
        flash.now[:error] = @user.errors.full_messages
        render :onboard
      end
  end

  def claim
    if current_user
      if current_user.relationships.any?
        redirect_to school_path(current_user.school_ids)
      else
        @user = current_user
      end
    end
  end

  def add_claim
    @user = current_user
    if @user.update_attributes(user_params)
      @user.update_attributes(temporary_school_ids: params[:user][:school_ids])
      Relationship.where(user_id: @user.id, school_id: @user.temporary_school_ids).last.delete
      redirect_to user_claim_verification_path(@user)
    else
      flash.now[:error] = @user.errors.full_messages
      render :claim
    end
  end

  def verification
    @user = current_user
    @identity_check = @user.identity_check
  end

  def verify_and_save
    @user = current_user
    @identity_check = @user.identity_check
    if @user.update_attributes(user_params.except(:identity_check))
      @verified = @identity_check.mobile_verification_code == @identity_check.mobile_verification_code_confirmation
      if @verified
        Relationship.create(user_id: @user.id, school_id: @user.temporary_school_ids)
        Emails.notify_of_school_claim(@user).deliver
        flash.now[:success] = "Account verified."
      else
        flash.now[:error] = "At least one of your codes is incorrect. Please double check and try again."
      end
    end
    respond_to do |format|
      format.js
    end
  end

  protected

  def load_claimable_schools
    @last_update = Relationship.all.map(&:created_at).max
    @schools = School.cached_claimable_schools(@last_update)
  end

  def user_params
    params.require(:user).permit({:preferred_search_locations => []}, :first_name, :last_name, :email, :mobile_phone_number, :password, :password_confirmation, :title, :company, :phone, :business_email, :business_phone, :phone_ext, :facebook, :linkedin, :twitter, :spa_ids, :nearest_city, :temporary_spa_ids, { identity_check_attributes: [:id, :user_id, :mobile_verification_code, :mobile_verification_code_confirmation, :mobile_verified, :email_verification_code, :email_verification_code_confirmation, :email_verified, :_destroy] })
  end
end