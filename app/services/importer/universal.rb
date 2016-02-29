class Importer::Universal < Importer::Base
  delegate :model, :failed_content, :failed_records, to: :context

  def call
    init_spreadsheet
    context.failed_records = []
    run_import
    handle_errors
  end

  def run_import
    spreadsheet.each_with_index(model_header) do |model_attributes, i|
      next if i.zero?
      attributes = model_attributes.slice(*model.column_names)
      attributes['address_attributes'] = model_attributes.slice(*address_attributes)
      object = model.where(id: attributes["id"]).first_or_initialize
      object.attributes = attributes
      object.sports = attributes["sports"].split(", ") if model == Club and attributes["sports"].present?
      object.school_affiliated = attributes["school_affiliated"].to_b if model == League
      object.is_private = attributes["is_private"].to_b if model == Facility
      object.publicly_visible = attributes["publicly_visible"].to_b if model == Facility
      handle_failure(attributes, object) unless object.save
    end
  end

  def handle_failure(attributes, object)
    super(failed_records, attributes, object)
  end

  def failed_content
    { model.class.to_s => failed_records }
  end

  def model_header
    header(spreadsheet)
  end

  def header_for(label)
    model_header
  end
end