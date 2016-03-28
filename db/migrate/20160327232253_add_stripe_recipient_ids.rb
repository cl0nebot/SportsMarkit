class AddStripeRecipientIds < ActiveRecord::Migration
  def change
    add_column :teams, :stripe_recipient_id, :integer
    add_column :schools, :stripe_recipient_id, :integer
    add_column :clubs, :stripe_recipient_id, :integer
    add_column :facilities, :stripe_recipient_id, :integer
    add_column :leagues, :stripe_recipient_id, :integer
  end
end
