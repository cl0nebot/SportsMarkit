class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      t.string :sport

      t.timestamps
    end
  end
end
