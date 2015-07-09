class LeagueSport < ActiveRecord::Base
  belongs_to :league
  belongs_to :sport
end
