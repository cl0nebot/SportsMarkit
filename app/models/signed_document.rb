class SignedDocument < ActiveRecord::Base
  belongs_to :user, foreign_key: :user_id
  belongs_to :document, foreign_key: :documents_id 
end
