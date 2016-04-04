class Verification < ActiveRecord::Base
  belongs_to :user
  belongs_to :verifiable, polymorphic: true, counter_cache: true
end
