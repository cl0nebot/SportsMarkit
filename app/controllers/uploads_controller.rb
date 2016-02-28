class UploadsController < ApplicationController
  
  def index
    
  end
  
  def import
    model = params[:object].constantize
    if params[:school_id].present?
      import = model.import_team(params[:file], params[:school_id])
      if import.failure?
        flash.now[:error] = import.context.message
        send_data import.error_xls and return
      end
    else
      model.import(params[:file], model)
    end
    redirect_to :back
  end
end
