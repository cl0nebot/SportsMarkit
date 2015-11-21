class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string   :name
      t.text     :description
      t.string   :classification
      t.string   :abbreviation
      t.string   :phone_number
      t.string   :email
      t.string   :website
      t.string   :slug
      t.string   :stripe_customer_id
      t.string   :stripe_subscription_id
      t.string   :facebook
      t.string   :twitter
      t.string   :linkedin
      t.string   :pinterest
      t.string   :instagram
      t.string   :foursquare
      t.string   :youtube
      t.float    :latitude,               limit: 24
      t.float    :longitude,              limit: 24
      t.boolean  :gmaps
      t.date     :last_payment

      t.boolean  :premium
      t.float    :price,                  limit: 24


      t.string   :colors
      t.string   :mascot
      t.string   :motto
      t.integer  :number_of_teams
      t.integer  :number_of_students
      t.string   :category
      t.integer  :founded
      t.integer  :enrollment
      t.integer  :faculty
      t.text     :sports
      t.string   :age_range
      t.string   :gender
      t.string   :level
      t.string   :selection_criteria
      t.string   :year_founded
      t.integer  :number_of_coaches
      t.integer  :number_of_athletes
      t.integer  :lowest_athlete_age
      t.integer  :oldest_athlete_age
      
      

      t.timestamps
    end
  end
end
