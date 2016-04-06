class FormBuilder::Text < FormBuilder::Base
  def field_tag
    text_field_tag field_name, value, base_options
  end

  def base_options
    options = super
    options.merge!({ minlength: @data["field_options"]["minlength"] }) if @data["field_options"]["minlength"]
    options.merge!({ maxlength: @data["field_options"]["maxlength"] }) if @data["field_options"]["maxlength"]
    options
  end
end