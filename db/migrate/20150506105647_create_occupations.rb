class CreateOccupations < ActiveRecord::Migration
  def change
    create_table :occupations do |t|
      t.string :title
      t.string :company
      t.date :start_date
      t.date :end_date
      t.boolean :current_job

      t.timestamps
    end
  end
end
