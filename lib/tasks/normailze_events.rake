namespace :events do
  desc "Remove guest accounts more than a week old."
  task :reschedule => :environment do
    Event.where(repeat_type: nil).update_all(repeat_type: 0)
    Event.includes(:event_schedules).where(event_schedules: { id: nil } ).each do |e|
      e.event_schedules.create(starts_at: e.starts_at, ends_at: e.ends_at)
    end
  end
end
