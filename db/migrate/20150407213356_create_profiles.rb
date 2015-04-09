class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.belongs_to :user
      
      
      ## Vitals.
      t.integer :height_ft
      t.integer :height_in
      t.integer :weight
      t.date :date_of_birth
      
      ## Sport specific.
      t.string :level
          
      # guardian
      t.string :guardian
      t.string :guardian_phone_number
      
      ## Social media.
      t.string :linkedin
      t.string :facebook
      t.string :instagram
      t.string :twitter
      
      ## Youth Education
      t.string :elementary_school
      t.string :middle_school
      t.string :highschool
      
      # Adult Education
      t.string :undergraduate_school
      t.string :graduate_school
      t.string :doctorate_school
      t.string :undergraduate_degree
      t.string :graduate_degree
      t.string :doctorate_degree
      t.string :undergraduate_major
      t.string :graduate_major
      t.string :doctorate_major
      t.integer :undergraduate_year
      t.integer :graduate_year
      t.integer :doctorate_year
      
      ## location & contact
      t.string :city
      t.string :offseason_city
      t.string :state
      t.string :zipcode
      t.string :mobile_phone_number
      
      ## collections
      t.string :focus
      t.string :specialties
      t.string :skills
      t.string :injuries
      t.string :current_ailments
      
      # specialists
      t.string :category
      t.string :company
      t.string :website
      t.string :title

      t.timestamps
    end
    add_index :profiles, :user_id
  end
end
