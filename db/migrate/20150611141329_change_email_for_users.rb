class ChangeEmailForUsers < ActiveRecord::Migration
  def change
    change_column :users, :email, :string
    remove_index :users, :email
  end
end
