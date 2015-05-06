class CreateSportIcons < ActiveRecord::Migration
  def change
    create_table :sport_icons do |t|
      t.belongs_to :sport
      t.string :icon
      t.timestamps
    end
  end
end
