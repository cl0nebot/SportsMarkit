class Importer::Roster < Importer::Universal
  include Importer::Concerns::Roster

  def run_import
    spreadsheet.each_with_index(model_header) do |model_attributes, i|
      next if i.zero?
      create_roster(model_attributes, context.team_id){|failure| handle_failure(model_attributes, failure)}
    end
  end
end