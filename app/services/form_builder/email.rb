class FormBuilder::Email < FormBuilder::Base
  def field_tag
    email_field_tag field_name, value, base_options.merge!({ "data-email" => true })
  end
end