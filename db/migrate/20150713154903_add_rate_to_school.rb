class AddRateToSchool < ActiveRecord::Migration
  def change
    add_column :schools, :price, :float
  end
end
