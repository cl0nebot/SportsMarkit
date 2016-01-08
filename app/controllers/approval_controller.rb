class ApprovalController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!
  
  def index
    @athletic_directors = Role.where(role: "Athletic Director", status: "Pending")
    @coaches = Role.where(role: "Coach", status: "Pending")
    @club_directors = Role.where(role: "Club Director", status: "Pending")
    @school_managers = Role.where(role: "School Manager", status: "Pending")
    @team_managers = Role.where(role: "Team Manager", status: "Pending")
  end
  
  def approve
    @role = Role.find(params[:id])
    @role.update_attributes(status: "Active")
    SendEmail.notify_user_of_admin_role(User.find(@role.user_id), @role.role, @role.roleable_type.constantize.find(@role.roleable_id))
    @athletic_directors = Role.where(role: "Athletic Director", status: "Pending")
    @coaches = Role.where(role: "Coach", status: "Pending")
    @club_directors = Role.where(role: "Club Director", status: "Pending")
    @school_managers = Role.where(role: "School Manager", status: "Pending")
    @team_managers = Role.where(role: "Team Manager", status: "Pending")
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end
  
end
