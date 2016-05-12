class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :form_id
      t.decimal :price, precision: 5, scale: 2, default: 0
      t.decimal :sm_fee, precision: 5, scale: 2, default: 0
      t.decimal :stripe_fee, precision: 5, scale: 2, default: 0
    end
  end
end
