class CreateVerifications < ActiveRecord::Migration
  def change
    create_table :verifications do |t|
      t.string :verifiable_type
      t.integer :verifiable_id
      t.integer :user_id
      t.timestamps
    end

    add_index :verifications, :verifiable_type
    add_index :verifications, :verifiable_id
  end
end
