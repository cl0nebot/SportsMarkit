class Connect < ActiveRecord::Base
  belongs_to :ownerable, polymorphic: true
  belongs_to :connectable, polymorphic: true
end
