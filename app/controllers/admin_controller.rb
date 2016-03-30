class AdminController < ApplicationController

  def index
  end

  def manage
    @value = params[:value]
    @objects = Admin.manage(@value)
  end

  def destroy
    @object = params[:object_type].constantize.find(params[:id])
    @object.destroy
    redirect_to :back
  end
end
