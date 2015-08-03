class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.belongs_to :user
      t.text :message
      t.integer :chatroom_id
      t.string :file      

      t.timestamps
    end
  end
end
