class ErrorsController < ApplicationController
  rescue_from Exception, :with => :server_error
  layout false
  
  def not_found
    render :status => 404, :formats => [:html]
  end

  def server_error(exception)
    ExceptionNotifier.notify_exception(exception,
      :env => request.env, :data => {:message => "was doing something wrong"})
    render :status => 500, :formats => [:html]
  end
end
