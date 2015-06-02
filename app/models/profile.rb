class Profile < ActiveRecord::Base
  include Location
  belongs_to :user
  
  serialize :focus, Array
  serialize :specialties, Array
  serialize :skills, Array
  serialize :injuries, Array
  serialize :current_ailments, Array
end
