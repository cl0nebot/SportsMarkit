class AddColsSchool < ActiveRecord::Migration
  def change
    add_column :schools, :last_payment, :date
    add_column :schools, :stripe_subscription_id, :string
    add_column :schools, :premium, :boolean
  end
end
