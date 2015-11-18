class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.belongs_to :user
      t.string :role
      t.integer :roleable_id
      t.string :roleable_type
      t.datetime :date_added
      t.integer :accepting_user_id
      t.string :status

      t.timestamps
    end
  end
end
