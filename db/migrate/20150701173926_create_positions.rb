class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.belongs_to :sport
      t.string :position
      t.timestamps
    end
  end
end
