class CertificatesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @certificate = @user.certificates.build
  end

  def destroy
    @certificate = Certificate.find(params[:id])
    @certificate.destroy
  end

  def update
    @certificate = Certificate.find(params[:id])
    @certificate.update(certificate_params)
    render nothing: true
  end

  def create
    @user = User.find(params[:user_id])
    @certificate = @user.certificates.build(certificate_params)
    @certificate.save
  end

  private

  def certificate_params
    params[:certificate].permit(:certification_id, :expiration, :user_id, :expires)
  end
end