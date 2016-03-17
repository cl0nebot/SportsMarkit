class SignedDocument < ActiveRecord::Base
  mount_uploader :file, PdfUploader

  belongs_to :user, foreign_key: :user_id
  belongs_to :document, foreign_key: :document_id
end
