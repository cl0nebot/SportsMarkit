class CreateUserlessRoles < ActiveRecord::Migration
  def change
    create_table :userless_roles do |t|
      t.string :first_name
      t.string :last_name
      t.string :role
      t.integer :userless_id
      t.string :userless_type
      t.datetime :date_added
      t.integer :accepting_user_id
      t.string :status
      t.string :mobile_phone_number
      t.string :level
      t.string :nickname
      t.string :jersey_number
      t.string :title

      t.timestamps
    end
  end
end
