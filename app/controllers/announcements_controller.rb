class AnnouncementsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user!
  require 'twilio-ruby'

  def index
    param = params.keys.find{|key| key =~ /(\w+)_id/}
    @object = $1.capitalize.constantize.find(params[param])
    @objects = @object.announcements
  end

  def create
    announcementable = announcement_params[:announceable_type].constantize.find(announcement_params[:announceable_id])
    @user_count = AnnouncementsService.new(announcementable, announcement_params, current_user).notify_users
    @announcement = current_user.announcements.create(announcement_params)

    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end

  private

  def announcement_params
    params.require(:announcement).permit(:announceable_type, :announceable_id,
      :message, :sms, :email, :subject, sports: [], team_ids: [],
      specific_user_groups: [], default_user_groups: [])
  end

  def correct_user!
    authenticate_user!
      param = params.keys.find{|key| key =~ /(\w+)_id/}
      if param
        @object = $1.capitalize.constantize.find(params[param])
      else
        @object = params[:announcement][:announceable_type].constantize.find(params[:announcement][:announceable_id])
      end
      unless @object.can_be_edited_by_user?(current_user)
        flash[:message] = "Unauthorized."
        redirect_to edit_user_path(current_user)
      end
  end
end
