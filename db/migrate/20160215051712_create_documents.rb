class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.references :documentable, :polymorphic => true
      t.string :file
      t.text :description
      t.string :name
      t.string :slug
      t.timestamps
    end
    add_index :documents, :slug, :unique => true
  end
end
