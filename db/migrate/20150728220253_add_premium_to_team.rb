class AddPremiumToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :premium, :boolean
  end
end
