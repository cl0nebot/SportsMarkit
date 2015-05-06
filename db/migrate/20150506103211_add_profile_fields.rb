class AddProfileFields < ActiveRecord::Migration
  def change
    add_column :profiles, :sex, :string
    
    ## Social media.
    add_column :profiles, :hudl, :string
    add_column :profiles, :youtube, :string
    add_column :profiles, :pinterest, :string
    add_column :profiles, :foursquare, :string
    
    #favorites
    add_column :profiles, :favorite_pro_team, :string
    add_column :profiles, :favorite_college_team, :string
    add_column :profiles, :favorite_pro_athlete, :string
    
    ## collections
    add_column :profiles, :hobbies, :string
    add_column :profiles, :gyms, :string
    
    ## music
    add_column :profiles, :song, :string
        
  end
end



