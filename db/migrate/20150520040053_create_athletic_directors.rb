class CreateAthleticDirectors < ActiveRecord::Migration
  def change
    create_table :athletic_directors do |t|
      t.belongs_to :user
      t.belongs_to :school
      t.boolean :accepted
      t.boolean :rejected
      t.string :mobile_phone_number

      t.timestamps
    end
  end
end
