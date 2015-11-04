class ContactMessagesController < ApplicationController
  
  
  def create
    @message = ContactMessage.new(contact_message_params)
    @message.save
    SendEmail.send_contact_message(@message).deliver
    respond_to do |format|
      format.js
      format.html {redirect_to :back}
    end
  end
  
  private
  
  def contact_message_params
    params.require(:contact_message).permit(:name, :email, :message, :spa_id, :user_id, :topic)
  end
  
  
end
