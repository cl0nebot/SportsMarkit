class FormBuilder::Dropdown < FormBuilder::Base
  include ActionView::Helpers::FormOptionsHelper
  def field_tag
    options = field_options.map do |option|
      [option["label"], option["label"]]
    end
    select_tag field_name, options_for_select(options), base_options
  end

  def base_options
    options = { required: required?, name: "user_data[#{field_name}]" }
    options.merge! include_blank: true if @data["field_options"]["include_blank_option"] == "true"
    options
  end
end