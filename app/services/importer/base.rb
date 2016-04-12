class Importer::Base
  include Interactor

  delegate :error_xls, :spreadsheet, :failure?, :file, :failed_content, to: :context

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

  def header(sheet)
    unless sheet.row(1).all?
      context.errors = {}
      sheet.row(1).each_with_index do |header, i|
        context.errors["Column #{i + 1}"] = "Header is missing" if header.blank?
      end
      context.fail!
    end
    Hash[sheet.row(1).map{ |column| [column.gsub(" ", "_").downcase, column] unless column == "Errors"}.compact]
  end

  def address_attributes
    %w(street_1 street_2 city county state country postcode suite)
  end

  def yes_or_no(val)
    val == "Yes" ? true : false
  end

  def handle_failure(target, attributes, error_record)
    if error_record.is_a? String
      target << (attributes.values << error_record)
    else
      target << (attributes.values << error_record.errors.full_messages.join(','))
    end
  end

  def handle_errors
    if failed_content.values.any?(&:present?)
      generate_error_csv
      context.fail!(error: 'Some records could not be processed, they were sent to you in separate csv file') rescue false
    end
  end

  def generate_error_csv
    package = Axlsx::Package.new

    errors = {}
    failed_content.each do |label, rows|
      package.workbook.add_worksheet(:name => label) do |sheet|
        sheet.add_row(header_for(label).values << 'Errors')
        rows.each_with_index do |row, index|
          sheet.add_row row
          errors["Line #{index}"] = row[-1]
        end
      end
    end

    context.errors = errors

    context.error_xls = package.to_stream
  end
end