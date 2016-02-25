class ChangeDocumentsIdToDocumentIdForSignedDocs < ActiveRecord::Migration
  def change
    rename_column :signed_documents, :documents_id, :document_id
  end
end
