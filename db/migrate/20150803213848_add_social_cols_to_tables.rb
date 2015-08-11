class AddSocialColsToTables < ActiveRecord::Migration
  def change
    #teams
    add_column :teams, :facebook, :string
    add_column :teams, :twitter, :string
    add_column :teams, :linkedin, :string
    add_column :teams, :pinterest, :string
    add_column :teams, :instagram, :string
    add_column :teams, :foursquare, :string
    add_column :teams, :youtube, :string
    #schools
    add_column :schools, :facebook, :string
    add_column :schools, :twitter, :string
    add_column :schools, :linkedin, :string
    add_column :schools, :pinterest, :string
    add_column :schools, :instagram, :string
    add_column :schools, :foursquare, :string
    add_column :schools, :youtube, :string
    #facilities
    add_column :facilities, :facebook, :string
    add_column :facilities, :twitter, :string
    add_column :facilities, :linkedin, :string
    add_column :facilities, :pinterest, :string
    add_column :facilities, :instagram, :string
    add_column :facilities, :foursquare, :string
    add_column :facilities, :youtube, :string
    #leagues
    add_column :leagues, :facebook, :string
    add_column :leagues, :twitter, :string
    add_column :leagues, :linkedin, :string
    add_column :leagues, :pinterest, :string
    add_column :leagues, :instagram, :string
    add_column :leagues, :foursquare, :string
    add_column :leagues, :youtube, :string
  end
    
end
