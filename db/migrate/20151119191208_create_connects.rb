class CreateConnects < ActiveRecord::Migration
  def change
    create_table :connects do |t|
      t.string :owner_type
      t.integer :owner_id
      t.string :connectable_type
      t.integer :connectable_id
      t.timestamps
    end
  end
end
