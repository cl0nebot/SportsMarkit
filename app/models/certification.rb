class Certification < ActiveRecord::Base
  
  
  
  def index_position
    array = []
    certifications = Certification.all
    certifications.each do |c|
      array << c.id
    end
    array.uniq.find_index(id) + 1
  end
  
  
end
