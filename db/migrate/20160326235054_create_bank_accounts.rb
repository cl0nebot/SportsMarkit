class CreateBankAccounts < ActiveRecord::Migration
  def change
    create_table :bank_accounts do |t|
      t.integer :bankable_id, null: false
      t.string :bankable_type, null: false
      t.string :name_on_account, null: false
      t.string :category, null: false
      t.timestamps
    end
  end
end

