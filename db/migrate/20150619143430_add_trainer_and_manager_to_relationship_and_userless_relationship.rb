class AddTrainerAndManagerToRelationshipAndUserlessRelationship < ActiveRecord::Migration
  def change
    add_column :userless_relationships, :manager, :boolean
    add_column :userless_relationships, :trainer, :boolean
    add_column :relationships, :manager, :boolean
    add_column :relationships, :trainer, :boolean
  end
end
