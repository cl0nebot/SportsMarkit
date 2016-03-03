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
      Importer::Team.call(file: file, school_id: school_id )
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


