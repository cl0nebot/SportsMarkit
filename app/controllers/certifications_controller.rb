class CertificationsController < ApplicationController
  
  def index
    @certifications = Certification.all
    @certification = Certification.new
  end
  
  def create
    @certification = Certification.new(certification_params)
    if @certification.save
      respond_to do |format|
        format.html{redirect_to :back}
        format.js
      end
    else
      respond_to do |format|
        format.html{redirect_to :back}
        format.js
      end
    end
  end
  
  def show
    
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
  protected
  
  def certification_params
    params.require(:certification).permit(:name, :issuer)
  end
  
  def find_certification
    
  end
end
