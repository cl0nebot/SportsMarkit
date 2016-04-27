class AddParentToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :parent, index: true
    change_column_null :users, :email, true
    change_column_default :users, :email, nil
    add_index :users, :email
  end
end
