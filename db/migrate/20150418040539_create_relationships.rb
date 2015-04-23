class CreateRelationships < ActiveRecord::Migration
  def change
    #create_table :relationships do |t|
    #  t.belongs_to :user
    #  t.belongs_to :team
    #  t.boolean :head
    #  t.string :head_title
    #  t.boolean :participant
    #  t.string :participant_classification
    #  t.string :position
    #  t.string :quote
    #  t.boolean  :accepted
    #  t.boolean  :rejected
    #  t.string :slug
    #  t.timestamps
    # end
    add_index :relationships, :slug, :unique => true
  end
end
