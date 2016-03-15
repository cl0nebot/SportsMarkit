class AddEventScheduleToAttendees < ActiveRecord::Migration
  def change
    add_reference :attendees, :event_schedule, index: true
    remove_reference :attendees, :event, index: true
  end
end
