class CreateLeagueManagers < ActiveRecord::Migration
  def change
    create_table :league_managers do |t|
      t.belongs_to :user
      t.belongs_to :league
      t.boolean :accepted
      t.boolean :rejected
      t.string :mobile_phone_number

      t.timestamps
    end
  end
end
