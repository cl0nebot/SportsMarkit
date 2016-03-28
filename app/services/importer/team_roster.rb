class Importer::TeamRoster < Importer::Base
  include Importer::Concerns::Roster

  delegate :error_xls, :spreadsheet, :failure?, :file, :failed_athletes, :failed_teams, :school_id, :school, to: :context

  def call
    init_spreadsheet
    check_for_spreadsheets
    return if failure?
    context.failed_teams = []
    context.failed_athletes = []
    import_teams
    import_athletes
    handle_errors
  end

  def check_for_spreadsheets
    unless (spreadsheet.sheets & required_sheets) == required_sheets
      context.fail!(error: "You don't have one of: '#{required_sheets.join(', ') }' sheets in your file") rescue false
    end
  end

  def required_sheets
    %w(Teams Athletes)
  end

  def failed_content
    {"Teams" => failed_teams, "Athletes" => failed_athletes}
  end

  def header_for(label)
    send("#{label.downcase.singularize}_header")
  end

  def team_header
    header(teams_spreadsheet)
  end

  def athlete_header
    header(athletes_spreadsheet)
  end

  def teams_spreadsheet
    spreadsheet.sheet('Teams')
  end

  def athletes_spreadsheet
    spreadsheet.sheet('Athletes')
  end

  def team_naming_attributes
    %w(level sex)
  end

  def team_name(atts)
    (atts.extract!(*team_naming_attributes).values << atts['sport']).join(' ')
  end

  def handle_failed_team(team_attributes, team)
    handle_failure(context.failed_teams, team_attributes, team)
  end

  def handle_failed_athlete(athlete_attributes, athlete)
    handle_failure(context.failed_athletes, athlete_attributes, athlete)
  end

  def import_teams
    teams_spreadsheet.each_with_index(team_header) do |team_attributes, i|
      next if i.zero?
      attributes = team_attributes.dup
      attributes['address_attributes'] = attributes.extract!(*address_attributes)
      attributes['name'] = team_name(attributes)
      attributes['teamable'] = context.teamable
      team = ::Team.where(id: attributes['id']).first_or_initialize
      team.attributes = attributes
      handle_failed_team(team_attributes, team) unless team.save
    end
  end

  def import_athletes
    athletes_spreadsheet.each_with_index(athlete_header) do |athlete_attributes, i|
      next if i.zero?
      attributes = athlete_attributes.dup
      team_name = attributes.extract!('category', 'sex', 'sport').values.join(' ')
      if team = context.teamable.teams.where(name: team_name).last
        team_id = team.id
      else
        handle_failed_athlete(athlete_attributes, "No team found with name: #{team_name}") and return
      end
      create_roster(attributes, team_id){|failure| handle_failed_athlete(athlete_attributes, failure)}
    end
  end
end