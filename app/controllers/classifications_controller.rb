class ClassificationsController < ApplicationController
  
  def create
    @classification = Classification.create(user_id: params[:classification][:user_id], classification: params[:classification][:classification])
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

