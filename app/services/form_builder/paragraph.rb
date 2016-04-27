class FormBuilder::Paragraph < FormBuilder::Base
  def field_tag
    text_area_tag field_name, value, base_options
  end
end