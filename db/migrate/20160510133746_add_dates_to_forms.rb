class AddDatesToForms < ActiveRecord::Migration
  def change
    add_column :forms, :start_date, :date
    add_column :forms, :end_date, :date
  end
end
