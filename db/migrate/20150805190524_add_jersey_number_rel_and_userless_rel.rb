class AddJerseyNumberRelAndUserlessRel < ActiveRecord::Migration
  def change
    add_column :relationships, :jersey_number, :string
    add_column :userless_relationships, :jersey_number, :string
  end
end
