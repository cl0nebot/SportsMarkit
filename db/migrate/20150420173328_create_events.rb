class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :user
      t.references :eventable, polymorphic: true, index: true
      t.string :event_type
      t.string :title
      t.datetime :starts_at
      t.datetime :ends_at
      t.boolean :all_day
      t.text :description
      t.boolean :private
      t.integer :created_by
      t.string :slug

      t.timestamps
    end
    add_index :events, :slug, :unique => true
  end
end
