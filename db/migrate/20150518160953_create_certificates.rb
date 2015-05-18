class CreateCertificates < ActiveRecord::Migration
  def change
    create_table :certificates do |t|
      t.belongs_to :user
      t.belongs_to :certification
      t.date :expiration
      t.boolean :expires
      t.timestamps
    end
  end
end
