class FormBuilder::Number < FormBuilder::Base
  def field_tag
    number_field_tag(field_name, value, base_options)
  end

  def base_options
    options = super
    if @data["field_options"]
      options.merge!({ min: @data["field_options"]["min"] }) if @data["field_options"]["min"]
      options.merge!({ max: @data["field_options"]["max"] }) if @data["field_options"]["max"]
      options.merge!({ step: "any" }) unless @data["field_options"]["integer_only"]
    end
    options
  end
end