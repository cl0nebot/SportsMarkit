class CreateSignedDocuments < ActiveRecord::Migration
  def change
    create_table :signed_documents do |t|
      t.references :user
      t.references :documents
      t.boolean :signed
      t.timestamps
    end
  end
end
