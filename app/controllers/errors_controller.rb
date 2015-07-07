class ErrorsController < ApplicationController
  
  def not_found
    respond_to do |format|
      format.any(:htm, :html, :xls, :xlsx) { render :status => 404, :formats => [:html] }
      format.all { render nothing: true, status: 404 }
    end
  end

  def server_error
    respond_to do |format|
      format.html { render :layout => false, :status => 500 }
      format.all { render nothing: true, status: 500}
    end
  end
  
end

