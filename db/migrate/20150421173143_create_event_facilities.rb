class CreateEventFacilities < ActiveRecord::Migration
  def change
    create_table :event_facilities do |t|
      t.belongs_to :event
      t.belongs_to :facility
      t.string :facility_type
      t.timestamps
    end
  end
end
