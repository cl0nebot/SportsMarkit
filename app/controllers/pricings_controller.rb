class PricingsController < ApplicationController
  
  def index
    @schools = School.all
  end
  
  def create
    @school = School.find(params[:school_id])
    @school.update_attributes(price: params[:price])
    respond_to do |format|
      format.html{redirect_to :back}
      format.js
    end
  end
  
  
end
