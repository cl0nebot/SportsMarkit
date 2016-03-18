class ChangeEventScheduleIdToEventId < ActiveRecord::Migration
  def change
    rename_column :attendees, :event_schedule_id, :event_id
  end
end
