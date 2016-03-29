class Importer::Team < Importer::Universal
  include Importer::Concerns::Roster

  delegate :error_xls, :spreadsheet, :failure?, :file, :failed_athletes, :failed_teams, :school_id, :school, to: :context

  def team_naming_attributes
    %w(level sex)
  end

  def team_name(atts)
    (atts.extract!(*team_naming_attributes).values << atts['sport']).join(' ')
  end

  def run_import
    spreadsheet.each_with_index(model_header) do |team_attributes, i|
      next if i.zero?
      attributes = team_attributes.dup
      attributes['address_attributes'] = attributes.extract!(*address_attributes)
      attributes['name'] = team_name(attributes)
      attributes['teamable'] = context.teamable
      team = ::Team.where(id: attributes['id']).first_or_initialize
      team.attributes = attributes
      handle_failure(team_attributes, team) unless team.save
    end
  end
end