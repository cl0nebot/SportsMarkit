class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string :name
      t.text :description
      t.string :sport
      t.string :state
      t.string :slug

      t.timestamps
    end
    add_index :leagues, :name
    add_index :leagues, :slug, :unique => true
  end
end
