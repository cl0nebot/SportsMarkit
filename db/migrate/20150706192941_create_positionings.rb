class CreatePositionings < ActiveRecord::Migration
  def change
    create_table :positionings do |t|
      t.belongs_to :position
      t.references :positionable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
