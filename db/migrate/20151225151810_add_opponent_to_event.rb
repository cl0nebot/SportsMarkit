class AddOpponentToEvent < ActiveRecord::Migration
  def change
    add_column :events, :opponent_id, :integer
    add_column :events, :opponent_type, :string
  end
end
