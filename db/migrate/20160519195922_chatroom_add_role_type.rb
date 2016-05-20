class ChatroomAddRoleType < ActiveRecord::Migration
  def change
    remove_column :chatrooms, :specific_id, :integer
    add_column :chatrooms, :role_type, :string
    add_index :chatrooms, :role_type

    Chatroom.destroy_all
    Team.all.each(&:create_all_chatrooms)
  end
end
