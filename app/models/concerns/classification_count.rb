module ClassificationCount
  extend ActiveSupport::Concern
  
  module ClassMethods
    
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
        
  end
end
