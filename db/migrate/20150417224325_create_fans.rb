class CreateFans < ActiveRecord::Migration
  def change
    create_table :fans do |t|
      t.belongs_to :user
      t.references :fannable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
