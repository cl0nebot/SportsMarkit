class MessagesController < ApplicationController


  
  def create
    @message = Message.new(user_id: params[:message][:user_id], message: params[:message][:message], chatroom_id: params[:message][:chatroom_id] )
    @message.save
    Pusher["chat-#{@message.chatroom_id}"].trigger('message-push', {
    })
  end
  
  
  def chatroom
    
    
  end
  
  # def events
  #   response.headers["Content-Type"] = "text/event-stream"
  #   start = Time.zone.now
  #   10.times do
  #     Message.uncached do
  #       Message.where('created_at > ?', start).each do |message|
  #         response.stream.write "data: #{message.to_json}\n\n"
  #         start = message.created_at
  #       end
  #     end
  #
  #     sleep 2
  #   end
  # rescue IOError
  #   logger.info "Stream closed"
  # ensure
  #   response.stream.close
  # end
  
  
end
