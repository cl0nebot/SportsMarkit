class UploadsController < ApplicationController
  
  def index
    
  end
  
  def import
    model = params[:object].constantize
    if params[:school_id].present?
      model.import_team(params[:file], params[:school_id])
    else
      model.import(params[:file], model)
    end
    redirect_to :back, notice: "Uploaded."
  end

  
  
end
