class MessagesController < ApplicationController

  def create
    message = Message.create(user_id: params[:message][:user_id], message: params[:message][:message], chatroom_id: params[:message][:chatroom_id] )
    Pusher["chat-#{message.chatroom_id}"].trigger('message-push', {message: message.message,
                                                user_id: message.user_id,
                                                user_name: User.find(message.user_id).full_name,
                                                file: message.file.try(:url),
                                                avatar: view_context.image_path(message.user.avatar),
                                                time: view_context.format(message.created_at, 8)
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
