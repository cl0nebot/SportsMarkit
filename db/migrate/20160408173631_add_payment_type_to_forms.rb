class AddPaymentTypeToForms < ActiveRecord::Migration
  def change
    add_column :forms, :payment_type, :integer, default: 0
  end
end
