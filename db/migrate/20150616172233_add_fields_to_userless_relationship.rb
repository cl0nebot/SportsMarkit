class AddFieldsToUserlessRelationship < ActiveRecord::Migration
  def change
    add_column :userless_relationships, :age, :integer
    add_column :userless_relationships, :nickname, :string
    add_column :relationships, :age, :integer
    add_column :relationships, :nickname, :string
  end
end
