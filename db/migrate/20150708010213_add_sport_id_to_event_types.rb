class AddSportIdToEventTypes < ActiveRecord::Migration
  def change
    add_column :event_types, :sport_id, :integer
  end
end
