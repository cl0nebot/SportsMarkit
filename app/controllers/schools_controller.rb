class SchoolsController < ApplicationController
  before_action :find_school, except: [:index, :new, :create]
  
  def index
    @schools = School.all
    @school = School.new
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def new
    @school = School.new
  end
  
  def create
    @school = School.new(school_params)
    if @school.save
      respond_to do |format|
        format.js
        format.html { redirect_to :back }
      end
    else
      render :new
    end
  end
  
  def show;end
  
  def edit;end
  
  def update
    if @school.update_attributes(school_params)
      respond_to do |format|
        format.js
        format.html { redirect_to :back }
      end
    else
      render :edit
    end
  end
  
  def destroy
    @school.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end
  
  protected
  
  def school_params
    params.require(:school).permit(:name, :classification, :abbreviation, :city, :state, :zip, :zip_ext, :latitude, :longitude, :gmaps, :phone_number, :email, :website, :slug)
  end
  
  def find_school
    @school = School.friendly.find(params[:id])
  end
end

