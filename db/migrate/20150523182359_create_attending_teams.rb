class CreateAttendingTeams < ActiveRecord::Migration
  def change
    create_table :attending_teams do |t|
      t.belongs_to :team
      t.belongs_to :tournament
      t.boolean :accepted
      t.boolean :paid

      t.timestamps
    end
  end
end
