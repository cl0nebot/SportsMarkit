class FansController < ApplicationController
  
  def create
    @fan = Fan.create(user_id: params[:fan][:user_id], fannable_id: params[:fan][:fannable_id], fannable_type: params[:fan][:fannable_type] )
    @fan.save
    @object = eval(@fan.fannable_type).find(@fan.fannable_id)
    @class = @object.class
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def destroy
    @fan = Fan.find(params[:id])
    @object = eval(@fan.fannable_type).find(@fan.fannable_id)
    @class = @object.class
    @fan.destroy
    respond_to do |format|
      format.js
      format.html
    end
  end
  
end
