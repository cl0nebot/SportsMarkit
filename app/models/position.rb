class Position < ActiveRecord::Base
  has_many :positionings, :dependent => :destroy
end
