class Admin
  
  def self.model(value)
    value.singularize.capitalize.constantize
  end
  
  def self.manage(value)
    self.model(value).all
  end
  
  def self.managed_objects
    %w[users schools leagues clubs facilities teams events documents]
  end 
  
  def self.attributes(value)
    hash = Hash.new
    Admin.send(value).each_with_index { |arr, i| hash[i.to_s] = arr } 
    hash
  end
  
  def self.users
    [['Name', 'full_name'], ['Email', 'email'],['Profile', 'slug'],["Dashboard", "slug"],['Manage', 'id']]
  end
  
  def self.schools
     [['Name', 'name'], ['Email', 'email'],['Profile', 'id'],["Dashboard", "slug"],['Manage', 'id']]
  end
  
  def self.teams
     [['Name', 'name'], ['Email', 'email'],['Profile', 'id'],["Dashboard", "slug"],['Manage', 'id']]
  end
  
  def self.facilities
     [['Name', 'name'], ['Email', 'email'],['Profile', 'id'],["Dashboard", "slug"],['Manage', 'id']]
  end
  
  def self.clubs
     [['Name', 'name'], ['Email', 'email'],['Profile', 'id'],["Dashboard", "slug"],['Manage', 'id']]
  end
  
  def self.leagues
     [['Name', 'name'], ['Email', 'email'],['Profile', 'id'],["Dashboard", "slug"],['Manage', 'id']]
  end
  
  def self.events
    [['Name', 'title'], ['Type', 'event_type'], ['Slug', 'slug'],['Profile', 'id'],['Manage', 'id']]
  end
  
  def self.documents
    [['Name', 'name'], ['Description', 'description'], ['Slug', 'slug'],['Profile', 'id'],['Manage', 'id']]
  end
  

end

