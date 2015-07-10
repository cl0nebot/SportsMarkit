class CreateLeagueSports < ActiveRecord::Migration
  def change
   create_table :league_sports do |t|
     t.integer :sport_id
    t.integer :league_id
   t.timestamps
    end
 end
end
