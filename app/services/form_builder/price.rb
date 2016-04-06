class FormBuilder::Price < FormBuilder::Base
  def field_tag
    number_field_tag field_name, value, base_options
  end
end