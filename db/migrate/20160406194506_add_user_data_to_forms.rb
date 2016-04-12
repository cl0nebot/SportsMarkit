class AddUserDataToForms < ActiveRecord::Migration
  def change
    add_column :forms, :user_data, :json, default: {}
  end
end
