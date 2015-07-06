class ErrorsController < ApplicationController
  
  def not_found
    respond_to do |format|
      format.any(:htm, :html, :xls, :xlsx) { render :status => 404, :formats => [:html] }
      format.all { render nothing: true, status: 404 }
    end
  end

  def server_error
    render :status => 500, :formats => [:html]
  end
  
end
