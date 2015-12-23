module Import
  extend ActiveSupport::Concern
  
  module ClassMethods
    #Users    
    
    def import(file, model)
      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1).collect { |column| column.gsub(" ", "_").downcase}
      ((spreadsheet.first_row + 1)..spreadsheet.last_row).each do |i|
        model_hash = Hash[[header, spreadsheet.row(i)].transpose].except("street_1", "street_2", "city", "county", "state", "country", "postcode", "suite")
        address_hash = Hash[[header, spreadsheet.row(i)].transpose].extract!("street_1", "street_2", "city", "county", "state", "country", "postcode", "suite")
        p model_hash
        p address_hash
        object = model.where(id: model_hash["id"])
        if object.count == 1 
          object.first.update_attributes(model_hash)
        else 
          new_object = model.new(model_hash.merge(id: model.last.try(:id).to_i + 1))
          new_object.sports = model_hash["sports"].split(", ") if model == Club
          new_object.school_affiliated = (model_hash["school_affiliated"] == "Yes" ? true : false) if model == League
          new_object.is_private = (model_hash["is_private"] == "Yes" ? true : false) if model == Facility
          new_object.publicly_visible = (model_hash["publicly_visible"] == "Yes" ? true : false) if model == Facility
          new_object.build_address(address_hash)
          new_object.save!
        end
      end
    end
    
    def import_team(file, school_id)
      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1).collect { |column| column.gsub(" ", "_").downcase}
      ((spreadsheet.first_row + 1)..spreadsheet.last_row).each do |i|
        original_hash = Hash[[header, spreadsheet.row(i)].transpose]
        model_hash = original_hash.except("street_1", "street_2", "city", "county", "state", "country", "postcode", "suite", "sex", "level")
        address_hash = original_hash.extract!("street_1", "street_2", "city", "county", "state", "country", "postcode", "suite")
        p model_hash
        p address_hash
        object = Team.where(id: model_hash["id"])
        if object.count == 1
          object.first.update_attributes(model_hash)
        else
          new_object = Team.new(model_hash.merge(id: Team.last.try(:id).to_i + 1))
          new_object.teamable_type = "School"
          new_object.teamable_id = school_id
          new_object.name = "#{original_hash["level"]} #{original_hash["sex"]} #{original_hash["sport"]}"
          new_object.build_address(address_hash)
          new_object.save!
        end
      end
      athlete_sheet = spreadsheet.sheet('Athletes')
      athlete_header = athlete_sheet.row(1).collect { |column| column.gsub(" ", "_").downcase}
      ((athlete_sheet.first_row + 1)..athlete_sheet.last_row).each do |i|
        athlete_hash = Hash[[athlete_header, athlete_sheet.row(i)].transpose]
          athlete_hash["mobile_phone_number"].present? ? object_type = Role : object_type = UserlessRole
          athlete_model_hash = Hash[[athlete_header, athlete_sheet.row(i)].transpose].except("sex", "sport", "category")
          object = object_type.where(id: athlete_model_hash["id"])

        if object.count == 1
          #object.first.update_attributes(athlete_model_hash)
        else
          team_id = School.find(school_id).teams.where(name: "#{athlete_hash["category"]} #{athlete_hash["sex"]} #{athlete_hash["sport"]}").last.id
          User.create_role_from_excel(athlete_model_hash.deep_symbolize_keys.merge(:team_id => team_id))
          
          #new_role = object_type.new(athlete_model_hash.merge(id: object_type.last.try(:id).to_i + 1))
          # object_type == Role ? new_role.roleable_type = "Team" : new_role.userless_type == "Team"

  #         new_role.role = "Athlete"
  #         object_type == Role ? User.create_new_user_and_roster_spot(athlete_hash["first_name"], athlete_hash["last_name"], athlete_hash["mobile_phone_number"], ["Athlete"], athlete_model_hash.deep_symbolize_keys.merge(:team_id => team_id) ) : UserlessRole.create_new_role( ["Athlete"], athlete_model_hash.deep_symbolize_keys.merge(:team_id => team_id))
        end
      end
    end
  
    def open_spreadsheet(file)
      case File.extname(file.original_filename)
        when ".csv" then Roo::CSV.new(file.path, csv_options: {encoding: "iso-8859-1:utf-8"})
        when ".xls" then Roo::Excel.new(file.path)
        when ".xlsx" then Roo::Spreadsheet.open(file.path, extension: :xlsx)
        else raise "Unknown file type: #{file.original_filename}"
      end
    end
  end
  
  
end


