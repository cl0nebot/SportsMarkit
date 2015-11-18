class ApprovalController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!
  
  def index
    @athletic_directors = Role.where(role: "Athletic Director", status: "Pending")
    @coaches = Role.where(role: "Coach", status: "Pending")
  end
  
  def approve
    @role = Role.find(params[:id])
    @role.update_attributes(status: "Active")
    @athletic_directors = Role.where(role: "Athletic Director", status: "Active")
    @coaches = Role.where(role: "Coach", status: "Active")
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end
  
end
