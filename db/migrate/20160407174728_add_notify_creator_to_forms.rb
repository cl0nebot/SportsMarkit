class AddNotifyCreatorToForms < ActiveRecord::Migration
  def change
    add_column :forms, :notify_creator, :boolean
  end
end
