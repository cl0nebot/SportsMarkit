class CreateChatrooms < ActiveRecord::Migration
  def change
    create_table :chatrooms do |t|
      t.integer :team_id
      t.integer :specific_id
      t.timestamps
    end
  end
end
