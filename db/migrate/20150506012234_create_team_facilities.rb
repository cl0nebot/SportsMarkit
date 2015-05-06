class CreateTeamFacilities < ActiveRecord::Migration
  def change
    create_table :team_facilities do |t|
      t.belongs_to :team
      t.belongs_to :facility
      t.timestamps
    end
  end
end
