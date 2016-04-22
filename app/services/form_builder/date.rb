class FormBuilder::Date < FormBuilder::Base
  def field_tag
    date_field_tag field_name, value, base_options
  end
end