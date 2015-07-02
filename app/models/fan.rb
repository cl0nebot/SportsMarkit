class Fan < ActiveRecord::Base
  belongs_to :fannable, polymorphic: true
  
  def user
    User.find(user_id)
  end
  
  

end
