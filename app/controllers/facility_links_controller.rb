class FacilityLinksController < ApplicationController


  def create
    @facility_link = FacilityLink.create(facilitatable_id: params[:facility_link][:facilitatable_id], facilitatable_type: params[:facility_link][:facilitatable_type], facility_id: params[:facility_link][:facility_id])
    @facility = @facility_link.facility
    @facility_link.save
    #@facilities = Team.find(@facility_link.team_id).facilities
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def destroy
    @facility_link = FacilityLink.find(params[:id])
    @object = @facility_link.facilitatable_type.constantize.find(@facility_link.facilitatable_id)
    @facility = @facility_link.facility
    @facility_link.destroy
    @facilities = @object.facilities
    respond_to do |format|
      format.js
      format.html
    end
  end
  
end