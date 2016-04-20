class AnnouncementsController < ApplicationController
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
end
