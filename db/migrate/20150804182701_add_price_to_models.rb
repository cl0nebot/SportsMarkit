class AddPriceToModels < ActiveRecord::Migration
  def change
    add_column :teams, :price, :float
    add_column :leagues, :price, :float
    add_column :facilities, :price, :float
  end
end
