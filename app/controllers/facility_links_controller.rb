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
  
  def add_multiple
    object = params[:facility_owner_type]
    object_id = params[:facility_owner_id]
    object.constantize.find(object_id).facility_links.destroy_all
    params[:facility_ids].each do |id|
      FacilityLink.create(facilitatable_type: object, facilitatable_id: object_id, facility_id: id)
    end
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