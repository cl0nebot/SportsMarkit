class AddRegistrationRequiredFieldToEvent < ActiveRecord::Migration
  def change
    add_column :events, :registration_required, :boolean
  end
end
