class AthleticDirector < ActiveRecord::Base
  belongs_to :school
  belongs_to :user
end
