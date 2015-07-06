class AddSignInCount < ActiveRecord::Migration
  def change
    add_column :users, :signin_count, :integer
  end
end
