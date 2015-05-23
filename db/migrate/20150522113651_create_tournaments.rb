class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.belongs_to :user
      t.string :name
      t.string :sport
      t.string :level
      t.text :description
      t.boolean :active
      t.boolean :director_paid
      t.string :slug

      t.timestamps
    end
    add_index :tournaments, :slug, :unique => true
  end
end
