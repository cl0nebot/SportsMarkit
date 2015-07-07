class ChangeSigninCount < ActiveRecord::Migration
  def change
    change_column :users, :signin_count, :integer, default: 0
  end
end
