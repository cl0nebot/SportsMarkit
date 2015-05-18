class CreateTeamLeagues < ActiveRecord::Migration
  def change
    create_table :team_leagues do |t|
      t.belongs_to :team
      t.belongs_to :league
      t.timestamps
    end
  end
end
