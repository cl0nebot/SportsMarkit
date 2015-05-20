class MovePhoneNumberFromProfileToUser < ActiveRecord::Migration
  def change
    add_column :users, :mobile_phone_number, :string
    remove_column :profiles, :mobile_phone_number
    add_column :relationships, :mobile_phone_number, :string
  end
end
