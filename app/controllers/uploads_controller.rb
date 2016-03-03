class UploadsController < ApplicationController
  before_action :find_object, only: [:index]
  
  def index
    
  end
  
  def import
    model = params[:object].constantize
    if params[:school_id].present?
      @import = Importer::Team.call(file: params[:file], school_id: params[:school_id])
    else
      @import = Importer::Universal.call(file: params[:file], model: model)
    end

    if @import.failure?
      flash.now[:error] = import.error
      if import.error_xls
        send_data(import.error_xls.read, type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', filename: "import-error-#{Time.now}.xlsx")
        return
      end
    else
      redirect_to :back, notice: 'Uploaded'
    end
  end

  def roster
    @import = Importer::Roster.call(file: params[:file], team_id: params[:team_id]) if params[:team_id].present?
    if @import.failure?
      flash.now[:error] = import.error
      if import.error_xls
        send_data(import.error_xls.read, type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', filename: "import-error-#{Time.now}.xlsx")
        return
      end
    else
      redirect_to :back, notice: 'Uploaded'
    end
  end
  
  private
  
  def find_object
    param = params.keys.find{|key| key =~ /(\w+)_id/}
    @object = $1.capitalize.constantize.find(params[param])
  end
  
end
