class PricingsController < ApplicationController
  
  def index
    @schools = School.all
    @teams = Team.without_schools
  end
  
  def add_or_update_price
    @object = params[:object].constantize.find(params[:id])
    @object.update_attributes(price: params[:price])
    respond_to do |format|
      format.html{redirect_to :back}
      format.js
    end
  end
  
  def edit
    @object = params[:object].constantize.find(params[:id])
    respond_to do |format|
      format.html{redirect_to :back}
      format.js
    end
  end
  

  
  
end
