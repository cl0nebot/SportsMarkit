class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.belongs_to :school
      t.belongs_to :league
      t.string :name
      t.string :sport
      t.string :slug
      

      t.timestamps
    end
  end
end
