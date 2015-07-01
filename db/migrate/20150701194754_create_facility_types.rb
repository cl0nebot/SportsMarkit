class CreateFacilityTypes < ActiveRecord::Migration
  def change
    create_table :facility_types do |t|
      t.string :facility_type

      t.timestamps
    end
  end
end
