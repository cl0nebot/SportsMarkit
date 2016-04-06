class FormBuilder::Number < FormBuilder::Base
  def field_tag
    number_field_tag(field_name, value, base_options) + @data["field_options"]["units"]
  end

  def base_options
    options = super
    options.merge({ min: @data["field_options"]["min"] }) if @data["field_options"]["min"]
    options.merge({ max: @data["field_options"]["max"] }) if @data["field_options"]["max"]
    options.merge({ pattern: "/\d+/" }) if @data["field_options"]["integer_only"]
  end
end