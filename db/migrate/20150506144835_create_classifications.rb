class CreateClassifications < ActiveRecord::Migration
  def change
    create_table :classifications do |t|
      t.belongs_to :user
      t.string :classification
      t.timestamps
    end
  end
end
