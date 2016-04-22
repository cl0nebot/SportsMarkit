class FormBuilder::Website < FormBuilder::Base
  def field_tag
    text_field_tag field_name, value, base_options.merge({ placeholder: "http://" })
  end
end