class AddCategoryToMedia < ActiveRecord::Migration
  def change
    add_column :media, :category, :string
  end
end
