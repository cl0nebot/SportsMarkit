class FormBuilder::Time < FormBuilder::Base
  def field_tag
    time_field_tag field_name, value, base_options
  end
end