class ClassificationsController < ApplicationController
  
  def create
    @user = User.find(params[:classification][:user_id])
    @user.classifications.destroy_all
    @classification = Classification.where(user_id: @user.id, classification: params[:classification][:classification]).first_or_create
    @type = params[:classification][:classification]
    @user = User.friendly.find(params[:classification][:user_id])
    @classification.save
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def destroy
    @classification = Classification.find(params[:id])
    @type = @classification.classification
    @user = @classification.user
    @classification.destroy
    respond_to do |format|
      format.js
      format.html
    end
  end
  
end

