module Map
  extend ActiveSupport::Concern
  
  def gmaps4rails_address
  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.address.street_1}, #{self.address.city}, #{self.address.state}" 
  end

  def city_state
    if self.class.to_s == "User"
      profile.residence
    else
      
    end
  end

end