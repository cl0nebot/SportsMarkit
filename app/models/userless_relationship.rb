class UserlessRelationship < ActiveRecord::Base
  belongs_to :team
  serialize :position, Array
end
