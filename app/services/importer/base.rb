class Importer::Base
  include Interactor

  def init_spreadsheet
    context.spreadsheet = open_spreadsheet(file)
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