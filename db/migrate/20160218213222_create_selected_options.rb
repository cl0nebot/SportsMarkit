class CreateSelectedOptions < ActiveRecord::Migration
  def change
    create_table :selected_options do |t|
      t.belongs_to :user
      t.belongs_to :form
      t.belongs_to :option
      

      t.timestamps
    end
  end
end
