class AthleticDirectorsController < ApplicationController
  
  def index
   @directors = Role.where(role: "Athletic Director") 
  end
  
  def destroy
    @director = Role.find(params[:id])
    @director.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end
  
  
  
end
