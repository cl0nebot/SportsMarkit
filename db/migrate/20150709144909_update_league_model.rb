class UpdateLeagueModel < ActiveRecord::Migration
  def change
    remove_column :leagues, :sport
    add_column :leagues, :school_affiliated, :boolean 
  end
end
