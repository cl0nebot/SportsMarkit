class CreateFacilityLinks < ActiveRecord::Migration
  def change
    create_table :facility_links do |t|
      t.string :facilitatable_type
      t.integer :facilitatable_id
      t.timestamps
    end
  end
end
