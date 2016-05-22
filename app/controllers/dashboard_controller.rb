class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user!
  before_action :find_object
  
  def index
  end
  
  def find_object
    param = params.keys.find{|key| key =~ /(\w+)_id/}
    @object = $1.capitalize.constantize.find(params[param])
  end
end
