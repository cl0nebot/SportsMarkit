module SetupHelper
  
  def objects(classification, user)
    case classification
    when "Athlete"
      objects = Team.without_schools
    when "Student Athlete" 
      objects = Team.with_schools
    when "Coach"
      objects = Team.all
    when "Guardian"
      objects = User.all - [user]
    when "Athletic Director"
      objects = School.all
    when "Club Director"
      objects = Club.all
    when "Team Manager"
      objects = Team.all
    when "School Manager"
      objects = School.all
    end
  end
  
  def role_for(classification)
    case classification
    when "Athlete"
      "Athlete"
    when "Student Athlete" 
      "Athlete"
    when "Coach"
      "Coach"
    when "Guardian"
      "Guardian"
    when "Athletic Director"
      "Athletic Director"
    when "Club Director"
      "Club Director"
    when "Team Manager"
      "Team Manager"
    when "School Manager"
      "School Manager"
    end
  end
  
  def selected_objects(classification, user)
    role_ids = Role.where(user_id: user.id, status: ["Pending", "Active"], role: classification).pluck(:roleable_id)
    case classification
    when "Athlete"
      roles = Team.without_schools.where(id: role_ids)
    when "Student Athlete" 
      roles = Team.with_schools.where(id: role_ids)
    when "Coach"
      roles = Team.all.where(id: role_ids)
    when "Guardian"
      roles = User.all.where(id: role_ids)
    when "Athletic Director"
      roles = School.all.where(id: role_ids)
    when "Club Director"
      roles = Club.all.where(id: role_ids)
    when "Team Manager"
      roles = Team.all.where(id: role_ids)
    when "School Manager"
      roles = School.all.where(id: role_ids)
    end
  end
  
  def object_description(classification)
    case classification
    when "Athlete"
      "Team"
    when "Student Athlete" 
      "Team"
    when "Coach"
      "Team"
    when "Guardian"
      "Child"
    when "Athletic Director"
      "School"
    when "Club Director"
      "Club"
    when "Team Manager"
      "Team"
    when "School Manager"
      "School"
    end
  end
  
  def typeahead(classification)
    case classification
    when "Athlete"
      "teams"
    when "Student Athlete" 
      "teams"
    when "Coach"
      "teams"
    when "Guardian"
      "users"
    when "Athletic Director"
      "schools"
    when "Club Director"
      "clubs"
    when "Team Manager"
      "teams"
    when "School Manager"
      "schools"
    end
  end
end
