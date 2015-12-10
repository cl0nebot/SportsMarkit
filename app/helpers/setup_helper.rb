module SetupHelper
  
  def objects(classification, user)
    case classification
    when "Athlete"
      objects = Team.without_schools.limit(20)
    when "Student Athlete" 
      objects = Team.with_schools.limit(20)
    when "Coach"
      objects = Team.all.limit(20)
    when "Parent"
      objects = User.all.limit(20) - [user]
    when "Athletic Director"
      objects = School.all.limit(20)
    when "Club Director"
      objects = Club.all.limit(20)
    when "Team Manager"
      objects = Team.all.limit(20)
    when "School Manager"
      objects = School.all.limit(20)
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
    when "Parent"
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
    when "Parent"
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
    when "Parent"
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
