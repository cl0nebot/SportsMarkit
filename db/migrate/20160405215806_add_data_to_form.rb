class AddDataToForm < ActiveRecord::Migration
  def change
    add_column :forms, :data, :json
  end
end
