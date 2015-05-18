class CertificationsController < ApplicationController
  
  def index
    @certifications = Certification.all
    @certification = Certification.new
    @certification_badge = @certification.certification_badges.build
  end
  
  def create
    @certification = Certification.new(certification_params)
    if @certification.save
      respond_to do |format|
        format.html{redirect_to :back}
        format.js
      end
    else
      flash.now[:error] = @certification.errors.full_messages
      respond_to do |format|
        format.html{redirect_to :back}
        format.js
      end
    end
  end
  
  def update
    @certification = Certification.find(params[:id])
    @index = @certification.index_position
    @before_item = @index - 1
    @result = @certification.update_attributes(certification_params)
    if @result
      flash[:success] = "Certification has been updated."
      respond_to do |format|
        format.js
        format.html { redirect_to :back }
      end
    else
      flash.now[:error] = @certification.errors.full_messages
      respond_to do |format|
        format.js
        format.html { redirect_to :back }
      end
    end
  end
  
  def destroy
    @certification = Certification.find(params[:id])
    @index = @certification.index_position
    @certification.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end
  
  
  protected
  
  def certification_params
    params.require(:certification).permit(:name, :issuer, certification_badges_attributes: [:id, :badge, :_destroy])
  end
end
  
