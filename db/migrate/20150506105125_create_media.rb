class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.belongs_to :user
      t.references :mediable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
