class Fan < ActiveRecord::Base
  belongs_to :fannable, polymorphic: true
  
  

end
