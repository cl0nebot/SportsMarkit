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
      redirect_to schools_path
    else
      render :new
    end
  end
  
  def show
    @json = @school.to_gmaps4rails
    @class = @school.class
    @object = @school
    @teams = @school.teams
    @athletes = @school.athletes
    @people = @school.people
  end
  
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
    params.require(:school).permit(:name, :classification, :abbreviation, :address_1, :address_2, :city, :state, :zip, :zip_ext, :latitude, :longitude, :gmaps, :phone_number, :email, :website, :slug)
  end
  
  def find_school
    @school = School.friendly.find(params[:id])
  end
end

