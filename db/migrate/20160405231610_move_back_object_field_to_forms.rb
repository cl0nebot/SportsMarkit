class MoveBackObjectFieldToForms < ActiveRecord::Migration
  def change
    add_column :forms, :object, :string
  end
end
