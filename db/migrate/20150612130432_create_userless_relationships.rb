class CreateUserlessRelationships < ActiveRecord::Migration
  def change
    create_table :userless_relationships do |t|
      t.belongs_to :team
      t.string :first_name
      t.string :last_name
      t.boolean :head
      t.string :head_title
      t.boolean :participant
      t.string :participant_classification
      t.string :position
      t.string :mobile_phone_number

      t.timestamps
    end
  end
end