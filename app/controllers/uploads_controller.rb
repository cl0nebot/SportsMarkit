class UploadsController < ApplicationController
  before_action :find_object, only: [:index]
  
  def index
    
  end
  
  def import
    model = params[:object].constantize
    if params[:school_id].present?
      import = model.import_team(params[:file], params[:school_id])
      if import.failure?
        if import.error_xls
          flash.now[:error] = import.error
          send_data(import.error_xls.read, type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', filename: "import-error-#{Time.now}.xlsx")
          return
        else
          flash[:error] = import.error
        end
      end
    else
      model.import(params[:file], model)
    end
    redirect_to :back
  end

  def roster
    model = params[:object].constantize
    if params[:team_id].present?
      model.import_team(params[:file], params[:team_id])
    else
    end
    redirect_to :back, notice: "Uploaded."
  end
  
  private
  
  def find_object
    param = params.keys.find{|key| key =~ /(\w+)_id/}
    @object = $1.capitalize.constantize.find(params[param])
  end
  
end
