class AddClassificationAndCategoryToLeague < ActiveRecord::Migration
  def change
    add_column :leagues, :classification, :string
    add_column :leagues, :category, :string
  end
end
