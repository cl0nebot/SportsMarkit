class MakeTeamPolymorphic < ActiveRecord::Migration
  def change
    add_column :teams, :teamable_type, :string
    add_column :teams, :teamable_id, :integer
  end
end
