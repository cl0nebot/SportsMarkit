class TeamFacility < ActiveRecord::Base
  belongs_to :team
  belongs_to :facility
end
