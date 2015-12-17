class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.belongs_to :user
      t.string :announceable_type
      t.integer :announceable_id
      t.text :message
      t.text :sports
      t.text :team_ids
      t.text :specific_user_groups
      t.text :default_user_groups
      t.boolean :sms
      t.boolean :email
      t.string :subject

      t.timestamps
    end
  end
end
