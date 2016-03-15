class CreateEventSchedules < ActiveRecord::Migration
  def change
    create_table :event_schedules do |t|
      t.references :event, index: true
      t.datetime :starts_at
      t.datetime :ends_at
      t.timestamps
    end

    add_column :events, :repeat_type, :integer
    add_column :events, :repeat_until, :date
  end
end
