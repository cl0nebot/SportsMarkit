class CreateOnlineStatuses < ActiveRecord::Migration
  def change
    create_table :online_statuses do |t|
      t.integer :user_id
      t.datetime :last_seen

      t.timestamps
    end
  end
end
