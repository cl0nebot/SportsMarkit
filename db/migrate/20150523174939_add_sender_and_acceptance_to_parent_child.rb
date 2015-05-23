class AddSenderAndAcceptanceToParentChild < ActiveRecord::Migration
  def change
    add_column :parent_children, :sender_id, :integer
    add_column :parent_children, :accepted, :boolean
  end
end
