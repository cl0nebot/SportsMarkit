class AddPeymentRequiredOptionToEvent < ActiveRecord::Migration
  def change
    add_column :events, :payment_required, :boolean, default: false
  end
end
