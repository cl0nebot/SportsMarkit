class CreateCertificationBadges < ActiveRecord::Migration
  def change
    create_table :certification_badges do |t|
      t.belongs_to :certification
      t.string :badge
      t.timestamps
    end
  end
end
