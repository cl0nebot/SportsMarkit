class FormBuilder::Dropdown < FormBuilder::Base
  def field_tag
    options = @data["field_options"]["options"].values.map do |radio|
      radio_button_tag field_name, radio["label"], radio["checked"] == "checked", base_options
    end.join
    select_tag field_name, options, include_blank: include_blank?, required: required?
  end

  def include_blank?
    @data["field_options"]["include_blank_option"] == "true"
  end
end