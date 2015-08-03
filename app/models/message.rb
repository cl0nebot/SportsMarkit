class Message < ActiveRecord::Base
  belongs_to :user
  
  def chatroom_location
    #"users/#{User.find(user_id).friendly_id}/chatrooms/#{chatroom_id}"
  end
  
  def self.chatroom_messages(team_id)
    Message.where(chatroom_id: team_id)
  end
  
  def first_message?
    id == Message.chatroom_messages(chatroom_id).first.id
  end
  
  def last_message?
    id == Message.chatroom_messages(chatroom_id).last.id
  end
  
  def prior_messages
    Message.chatroom_messages(chatroom_id).where('created_at < ? ', created_at )
  end
  
  def prior_message_user_id
    prior_messages.any? ? prior_messages.last.user_id : nil
  end
  
  def next_messages
    Message.chatroom_messages(chatroom_id).where('created_at > ? ', created_at )
  end
  
  def next_message_user_id
    next_messages.any? ? next_messages.first.user_id : nil
  end
  
  def next_message_id
    next_messages.any? ? next_messages.first.id : nil
  end
  
  def time_elapsed_is_more_than_3_minutes
    if Message.chatroom_messages(chatroom_id).where('created_at < ? ', created_at ).any?
      (created_at - Message.chatroom_messages(chatroom_id).where('created_at < ? ', created_at ).last.created_at) > 3.minutes
    else
      true
    end
  end
  
  def beginning_of_stream?
    first_message? or ( prior_message_user_id != user_id )
  end
  
  def end_of_stream?
    last_message? or ( next_message_user_id != user_id )
  end
  
  def find_beginning_of_stream
    if beginning_of_stream?
      id
    else
      beginning = []
      prior_messages.each do |message|
        if message.beginning_of_stream?
          beginning << message.id
        end
      end
      beginning.last
    end
  end
  
  def beginning_of_stream
    Message.find(find_beginning_of_stream)  
  end
  
  def find_end_of_stream
    if end_of_stream?
      id
    else
      ending = []
      next_messages.each do |message|
        if message.end_of_stream?
          ending << message.id
        end
      end
      ending.first
    end
  end
  
  
  def cached_find_end_of_stream
   # Rails.cache.fetch([self, "ending_of_stream_for_message_#{id}"]) { find_end_of_stream }
  end
  
  def cached_find_beginning_of_stream
    #Rails.cache.fetch([self, "beginning_of_stream_for_message_#{id}"]) { find_beginning_of_stream }
  end
  
  def message_stream
    Message.where(id: find_beginning_of_stream..find_end_of_stream, chatroom_id: chatroom_id)
  end
  
  def cached_beginning_of_message_stream
    #Rails.cache.fetch([self, "beginning_of_message_stream", id]) { self.city_filters_for_spas(spas, current_filters) }
  end
  
end
