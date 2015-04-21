class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.references :event
      t.references :user
      t.boolean :yes
      t.boolean :maybe
      t.boolean :no
      t.timestamps
    end
  end
end
