class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :name
      t.text :description
      t.float :price
      t.integer :form_id
      t.string :object

      t.timestamps
    end
  end
end
