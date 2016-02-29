class UploadsController < ApplicationController
  
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
<<<<<<< HEAD
end
=======
end
>>>>>>> 5a70946257d5b444bd579b440bc47f5e17de5a35
