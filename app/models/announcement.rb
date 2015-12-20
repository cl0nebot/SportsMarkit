class Announcement < ActiveRecord::Base
  belongs_to :announceable, polymorphic: true
  
  validates :message, :presence => true, length: {minimum: 10, maximum: 480}
  
  
  #arrays
  serialize   :sports, Array
  serialize   :team_ids, Array
  serialize   :specific_user_groups, Array
  serialize   :default_user_groups, Array
  
  
  def specific_sent_to
    if specific_user_groups.include?("All")
      sent = "All users"
    elsif (specific_user_groups.nil? || specific_user_groups == [""])
      sent = "No users"
    else
      sent = specific_user_groups.join(", ")
    end
    "#{sent} at #{announceable_type.downcase} management level and "
  end
  
  def default_sent_to
    if default_user_groups.include?("All")
      sent = "All users"
    elsif (default_user_groups.nil? || default_user_groups == [""])
      sent = "No users"
    else
      sent = default_user_groups.join(", ")
    end
    "#{sent} at team and/or sport level."
  end
  
  def sent_to
     specific_sent_to +  default_sent_to
  end
  
  def sent_as
    array =[]
    array << "SMS" if sms?
    array << "Email" if email?
    array.join(", ") 
  end

  
 
end