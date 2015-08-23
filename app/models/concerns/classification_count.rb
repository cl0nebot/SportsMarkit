module ClassificationCount
  extend ActiveSupport::Concern
  
  module ClassMethods
    
    #Users
    
    def student_athlete_count
      count = 0
      User.all.each do |user|
        if user.classification_list.include? "Student Athlete"
          count += 1
        end
      end
      count
    end 
    
    def athlete_count
      count = 0
      User.all.each do |user|
        if user.classification_list.gsub("Student Athlete", "").include? "Athlete"
          count += 1
        end
      end
      count
    end
    
    def coach_count
      count = 0
      User.all.each do |user|
        if user.classification_list.include? "Coach"
          count += 1
        end
      end
      count
    end 
    
    def parent_count
      count = 0
      User.all.each do |user|
        if user.classification_list.include? "Parent"
          count += 1
        end
      end
      count
    end 
    
    def athletic_director_count
      count = 0
      User.all.each do |user|
        if user.classification_list.include? "Athletic Director"
          count += 1
        end
      end
      count
    end
    
    #Schools
    
    def high_school_count
      where(classification: "High School").count
    end
    
    def middle_school_count 
      where(classification: "Middle School").count
    end
    
    def elementary_school_count
      where(classification: "Elementary School").count
    end
    
    def public_school_count
      where(category: "Public").count
    end
    
    def private_school_count
      where(category: "Private").count
    end
    
    def charter_school_count
      where(category: "Charter").count
    end
    
     #Leagues
     
     def school_district_count
       where(classification: "School").count
     end
     
     def recreational_count
       youth_count + adult_count
       
     end
     
     def youth_count
       where(classification: "Recreational: Youth").count
     end
     
     def adult_count
       where(classification: "Recreational: Adult").count
     end
     
    
        
  end
end
