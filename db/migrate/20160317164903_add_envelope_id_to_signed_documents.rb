class AddEnvelopeIdToSignedDocuments < ActiveRecord::Migration
  def change
    add_column :signed_documents, :envelope_id, :string
    add_column :signed_documents, :file, :string
  end
end
