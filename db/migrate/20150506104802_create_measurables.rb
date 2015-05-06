class CreateMeasurables < ActiveRecord::Migration
  def change
    create_table :measurables do |t|
      t.belongs_to :user
      t.boolean :verified
      t.string :measurable
      t.string :result
      t.string :sport

      t.timestamps
    end
  end
end
