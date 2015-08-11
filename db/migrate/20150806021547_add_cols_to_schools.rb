class AddColsToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :description, :text
    add_column :schools, :colors, :string
    add_column :schools, :mascot, :string
    add_column :schools, :motto, :string
    add_column :schools, :number_of_teams, :integer
    add_column :schools, :number_of_students, :integer
  end
end
