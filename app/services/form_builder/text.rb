class FormBuilder::Text < FormBuilder::Base
  def field_tag
    text_field_tag field_name, value, base_options
  end
end