class AthleticDirectorsController < ApplicationController
  
  def index
   @directors = AthleticDirector.all  
  end
  
  def destroy
    @director = AthleticDirector.find(params[:id])
    @director.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end
  
  
  
end
