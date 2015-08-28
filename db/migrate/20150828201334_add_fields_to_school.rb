class AddFieldsToSchool < ActiveRecord::Migration
  def change
    add_column :schools, :founded, :integer
    add_column :schools, :enrollment, :integer
    add_column :schools, :faculty, :integer
  end
end
